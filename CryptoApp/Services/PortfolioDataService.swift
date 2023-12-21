//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 14/12/2023.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    // create a container
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container =  NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading container \(error)")
            }
            self.getPortfolio()
        }
    }
    
    
    // MARK: Public
    func updatePortfolio(coin: CoinModel, amount: Double) {
        // check if the coin exits in the portfolio to determine if we are updating or deleting
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            }else {
                delete(entity: entity)
            }
            // if we do not find the coin in the portfolio then we add it
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    

    // MARK: Private
    // fetct data from the container
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio \(error)")
        }
    }
    
    // add portfolio coins to coredata
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        
        // save the data
        applyChanges()
    }
    
    
    // update coins
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving data to coredata \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
  
}

