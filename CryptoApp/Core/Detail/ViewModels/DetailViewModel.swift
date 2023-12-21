//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 19/12/2023.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var overviewStats: [StatisticsModel] = []
    @Published var additionalStats: [StatisticsModel] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    private let coinDetailService: CoinDetailDataService
    private var cancellabes = Set<AnyCancellable>()
    @Published var coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapCoinDetailsToStats)
            .sink {[weak self] returnedArrays in
                self?.overviewStats = returnedArrays.overview
                self?.additionalStats = returnedArrays.additional
            }
            .store(in: &cancellabes)
        
        coinDetailService.$coinDetails
            .sink {[weak self] returnedDetails in
                self?.coinDescription = returnedDetails?.description?.en
                self?.websiteURL = returnedDetails?.links?.homepage?.first
                self?.redditURL = returnedDetails?.links?.subredditURL
            }
            .store(in: &cancellabes)
        
    }
    
    private func mapCoinDetailsToStats(coinDetails: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticsModel], additional: [StatisticsModel]) {
        // MARK: Over view
        let overviewArray = overviewArray(coinModel: coinModel)
        // MARK: Additional
        let additionalArray = additionalArray(coinModel: coinModel, coinDetails: coinDetails)
     
        return (overviewArray, additionalArray)
      
    }
    
    private func overviewArray(coinModel: CoinModel) -> [StatisticsModel] {
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticsModel(title: "Current price", value: price, percentageChange: pricePercentChange)
        
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticsModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticsModel(title: "Rank", value: rank)
        
        let volume =  "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticsModel(title: "Volume", value: volume)
        
        let overView: [StatisticsModel]  = [priceStat, marketCapStat, rankStat, volumeStat]
        return overView
    }
    
    private func additionalArray(coinModel: CoinModel, coinDetails: CoinDetailModel?) -> [StatisticsModel] {
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticsModel(title: "24H High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticsModel(title: "24H Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticsModel(title: "24H Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = "$" + (coinModel.marketCapChangePercentage24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapPercentChangeStat = StatisticsModel(title: "24H Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime = coinDetails?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticsModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetails?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticsModel(title: "Hashing algorithm", value: hashing)
        
        let additionalArray: [StatisticsModel] = [
            highStat, lowStat, priceChangeStat, marketCapPercentChangeStat, blockStat, hashingStat
        ]
        return additionalArray
    }
}
