//
//  SettingsViewModel.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 19/12/2023.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var coffeeURL: URL
    @Published var defaultURL: URL
    @Published var githubProfile: URL
    @Published var personalWebsite: URL
    @Published var coingeckoURL: URL
    @Published var developerImageURL: URL
    
    // the following urls have been force unwrapped because i know they will always be there but this should not be the right way always be safe and use a guard or if let
    init() {
        self.coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
        self.defaultURL = URL(string: "https://www.google.com")!
        self.githubProfile = URL(string: "https://www.github.com/huss3n")!
        self.personalWebsite = URL(string: "https://hussein-aisak.vercel.app/")!
        self.coingeckoURL = URL(string: "https://www.coingecko.com/")!
        self.developerImageURL = URL(string: "https://hussein-aisak.vercel.app/me.JPG")!
    }
}
