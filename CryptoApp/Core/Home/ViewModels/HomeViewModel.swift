//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 07/11/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var stats: [StatisticsModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOptions = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    enum SortOptions {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    
    init() {
        addSubscribers()
    }
    
    // add a subscriber to all coins from the Coin service -> its a publisher
    func addSubscribers() {
        // add the search publisher
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // <- runs after 0.5 seconds after user stops typing
            .map (filterAndSortCoins)
            .sink {[weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates the portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModels, portfolioEntites) -> [CoinModel] in
                coinModels
                    .compactMap { (coin) -> CoinModel? in
                        guard let entity = portfolioEntites.first(where: { $0.coinID == coin.id }) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink {[weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // updates the market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map{ (marketDataModel, portfolioCoins: [CoinModel]) -> [StatisticsModel] in
                var stats: [StatisticsModel] = []
                
                guard let data = marketDataModel else {
                    return stats
                }
                let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
                
                let volume = StatisticsModel(title: "24h Volume", value: data.volume)
                let btcDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
                
                
                //                let portfolioValue = portfolioCoins.map { (coin) -> Double in
                //                    return coin.currentHoldingsValue
                //                }
                
                let portfolioValue = portfolioCoins
                    .map({ $0.currentHoldingsValue})
                    .reduce(0, +)
                
                let previousValue = portfolioCoins.map { (coin) -> Double in
                    let currentValue = coin.currentHoldingsValue
                    let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                    let previousValue = currentValue / (1 + percentChange)
                    return previousValue
                }
                    .reduce(0, +)
                
                let percentageChange = ((portfolioValue - previousValue) / previousValue) 
                
                let portfolio = StatisticsModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
                
                stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
                return stats
            }
            .sink {[weak self] (returnedStats) in
                self?.stats = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        
    }
    
    private func filterAndSortCoins(text: String, coin: [CoinModel], sort: SortOptions) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coin)
        sortCoins(sort: sort, coin: &updatedCoins)
        // sort coins
        return updatedCoins
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        return coins.filter { (coin) in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func sortCoins(sort: SortOptions, coin: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coin.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coin.sort(by: { $0.rank > $1.rank })
        case .price:
            coin.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coin.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    func reloaddata() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
}


