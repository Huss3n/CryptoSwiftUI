//
//  Settings.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 19/12/2023.
//

import SwiftUI

struct Settings: View {
    @StateObject private var vm: SettingsViewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                appDetails
                coinGeckoDetails
                developerDetails
                applicationSection
            }
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XmarkButton()
                }
            }
        }
    }
}

#Preview {
    Settings()
}


extension Settings {
    private var appDetails: some View {
        Section("Crypto App") {
            VStack(alignment: .leading, spacing: 10) {
                Image("logo")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                Text("This app fetches the coin details and displays them in a visually appealing User interface using the MVVM Architecture. The app uses Combine, CoreData.")
                Text("The app was made possible by Nick Sarno of Swiftful thinking who I really appreciate for his great contribution and 3am lectures and code alongs that helped me through my journey of becoming an iOS developer")
                
                Link("Support his coffee addiction ☕️", destination: vm.coffeeURL)
                    .foregroundStyle(.blue)
            }
            .lineSpacing(6)
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.vertical)
    }
    
    private var coinGeckoDetails: some View {
        Section("CoinGecko") {
            VStack(alignment: .leading, spacing: 10) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text("This app uses the coin gecko api to fetch the coin details data. The api is provided for free by coingecko and they deserve the credit for their amazing endpoints")
                
                Link("Visit coin gecko", destination: vm.coingeckoURL)
                    .foregroundStyle(.blue)
            }
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.vertical)
    }
    
    private var developerDetails: some View {
        Section("Developer") {
            VStack(alignment: .leading, spacing: 10) {
                
                AsyncImage(url: vm.developerImageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
//                        .padding()
                } placeholder: {
                    ProgressView()
                }
                
            
                
                Text("This app was developed by Hussein Muktar. It uses combines publishers and subscribers for multi-threading. It also persists data using CoreData. The UI was written using SwiftUI and 100% swift language. Check out my portfolio below")
                
                Link("Developer website", destination: vm.personalWebsite)
                    .foregroundStyle(.blue)
            }
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(Color.theme.secondaryText)
    }
    
    private var applicationSection: some View {
        Section("Application") {
            VStack(alignment: .leading, spacing: 20) {
                Link("Terms of service", destination: vm.defaultURL)
                Link("Privacy Policy", destination: vm.defaultURL)
                Link("Company website", destination: vm.defaultURL)
                Link("Learn More", destination: vm.defaultURL)
            }
            .foregroundStyle(.blue)
            
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(Color.theme.secondaryText)
    }
    
    
}
