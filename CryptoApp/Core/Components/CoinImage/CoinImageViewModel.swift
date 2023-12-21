//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 08/11/2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
        
    private var cancellable = Set<AnyCancellable>()
    private var coinImageService: CoinImageService
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinImageService = CoinImageService(coin: coin)
        self.addSubscriber()
        self.isLoading = true
    }
    
    func addSubscriber() {
        coinImageService.$image
            .sink(receiveCompletion: {[weak self] _ in
                self?.isLoading = false
            }, receiveValue: {[weak self] returnedImage in
                self?.image = returnedImage
            })
            .store(in: &cancellable)
    }
}
