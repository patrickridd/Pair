//
//  EntityController.swift
//  Pair
//
//  Created by Patrick Ridd on 8/26/16.
//  Copyright © 2016 PatrickRidd. All rights reserved.
//

import Foundation
import CoreData

class EntityController {

    static let sharedController = EntityController()
    let moc = Stack.sharedStack.managedObjectContext
    
    var entities = [Entity]()
    
    let fetchedResultsController: NSFetchedResultsController
    
    init() {
        
        let request = NSFetchRequest(entityName: "Entity")
        request.sortDescriptors = []
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        _ = try? fetchedResultsController.performFetch()
    }
    
    func addEntity(name: String) {
        let _ = Entity(name: name)
        saveContext()
    }
    
    
    func saveContext() {
        do {
            try moc.save()
        } catch let error as NSError {
            print("Couldn't save to Context. Error: \(error.localizedDescription)")
        }
        
            }
    
    func fetchContext() {
        
    }
    
    
}