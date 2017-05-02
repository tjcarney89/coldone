//
//  CoreDataStack.swift
//  Cold One
//
//  Created by TJ Carney on 4/25/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {
    static let sharedInstance = CoreDataStack()
    private init () {}
    
    var savedBrews: [Brew] = []
    var pouredBrews: [Brew] = []
    let stateNames = ["Alaska",
                      "Alabama",
                      "Arkansas",
                      "Arizona",
                      "California",
                      "Colorado",
                      "Connecticut",
                      "Delaware",
                      "Florida",
                      "Georgia",
                      "Hawaii",
                      "Iowa",
                      "Idaho",
                      "Illinois",
                      "Indiana",
                      "Kansas",
                      "Kentucky",
                      "Louisiana",
                      "Massachusetts",
                      "Maryland",
                      "Maine",
                      "Michigan",
                      "Minnesota",
                      "Missouri",
                      "Mississippi",
                      "Montana",
                      "North Carolina",
                      "North Dakota",
                      "Nebraska",
                      "New Hampshire",
                      "New Jersey",
                      "New Mexico",
                      "Nevada",
                      "New York",
                      "Ohio",
                      "Oklahoma",
                      "Oregon",
                      "Pennsylvania",
                      "Rhode Island",
                      "South Carolina",
                      "South Dakota",
                      "Tennessee",
                      "Texas",
                      "Utah",
                      "Virginia",
                      "Vermont",
                      "Washington",
                      "Wisconsin",
                      "West Virginia",
                      "Wyoming"]
    
    var states: [USState] = []
    

    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Brew")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchData() {
        let context = persistentContainer.viewContext
        let savedBrewFetchRequest: NSFetchRequest<Brew> = Brew.fetchRequest()
        savedBrewFetchRequest.predicate = NSPredicate(format: "isSaved == true")
        let pouredBrewFetchRequest: NSFetchRequest<Brew> = Brew.fetchRequest()
        pouredBrewFetchRequest.predicate = NSPredicate(format: "isPoured == true")
        let statesFetchRequest: NSFetchRequest<USState> = USState.fetchRequest()
        do {
            self.savedBrews = try context.fetch(savedBrewFetchRequest)
            self.pouredBrews = try context.fetch(pouredBrewFetchRequest)
            self.pouredBrews.sort(by: { (brew1, brew2) -> Bool in
                brew1.isFavorite && !brew2.isFavorite
            })
            self.states = try context.fetch(statesFetchRequest)
            self.states.sort(by: { (state1, state2) -> Bool in
                if state1.isFilled == state2.isFilled {
                    return state1.name! < state2.name!
                }
                return state1.isFilled && !state2.isFilled
            })
        } catch {
            
        }
    }
    
    func makeBrew(beer: Beer) -> Brew {
        let context = persistentContainer.viewContext
        let brew = Brew(context: context)
        brew.name = beer.name
        brew.brewery = beer.brewery?.name
        brew.state = beer.brewery?.state.name
        brew.style = beer.style
        brew.abv = beer.abv
        brew.isFavorite = false
        brew.isSaved = false
        brew.isPoured = false
        return brew
    }
    
    func makeStates() {
        let context = persistentContainer.viewContext
        for state in stateNames {
            let usState = USState(context: context)
            usState.name = state
            usState.isFilled = false
            states.append(usState)
        }
    }
    
    func deleteBrew(brew: Brew) {
        let context = persistentContainer.viewContext
        context.delete(brew)
        saveContext()
    }
}
