//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 07/11/2023.


import Foundation
import Combine

class CoinDataService: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    
    var cancellables = Set<AnyCancellable>()
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
     func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel() // <- cancels the publisher after fetching data
            })
    }
    
    func downloadData(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

