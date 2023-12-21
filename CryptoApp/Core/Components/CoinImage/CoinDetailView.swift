//
//  CoinDetailView.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 13/12/2023.
//

import SwiftUI

struct CoinDetailView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}


struct CoinDetailView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        CoinDetailView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
