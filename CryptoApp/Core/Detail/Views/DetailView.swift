//
//  DetailView.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 17/12/2023.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    @StateObject private var vm: DetailViewModel
    @State private var readMore: Bool = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing coin \(coin.name)")
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    coinDescriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    additionalSection
                    
                }
                .padding()
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationNameAndImage
            }
        }
        .navigationTitle(vm.coin.name)
    }
}

struct DetailView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(coin:dev.coin)
        }
    }
}


extension DetailView {
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title.bold())
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var coinDescriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription.removingHTMLOccurences)
                        .lineLimit(readMore ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    
                    Button(action: {
                        withAnimation(.easeIn) {
                            readMore.toggle()
                        }
                    }, label: {
                        Text(readMore ? "Less" : "Read more")
                            .font(.subheadline.bold())
                            .padding(.vertical, 3)
                    })
                    .tint(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }
    }
    
    private var additionalTitle: some View {
        Text("Additional Info")
            .font(.title.bold())
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            // website
            if let websiteURL = vm.websiteURL,
               let url = URL(string: websiteURL) {
                Link("Website", destination: url)
            }
            
            // reddit rul
            if let redditString = vm.redditURL,
               let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.overviewStats) { stat in
                    StatisticsView(stat: stat)
                }
            })
    }
    
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.additionalStats) { stat in
                    StatisticsView(stat: stat)
                }
            })
    }
    
    private var navigationNameAndImage: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
        .padding(.trailing, 2)
    }
}
