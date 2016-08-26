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
    
    var numberOfObjects: Int {
        
        guard let numberOfObjects = fetchedResultsController.fetchedObjects?.count else {
            return 0
        }
        
        return numberOfObjects
    }
    
    let fetchedResultsController: NSFetchedResultsController
    
    init() {
        
        let request = NSFetchRequest(entityName: "Entity")
        request.sortDescriptors = [NSSortDescriptor(key: "group", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: "group", cacheName: nil)
        
        _ = try? fetchedResultsController.performFetch()
        self.entities = (fetchedResultsController.fetchedObjects as? [Entity]) ?? []

    }
    
    func addEntity(name: String) {
        
//        if numberOfObjects%2 != 0 {
//        } else {
//            let groupNumber = numberOfObjects/2
//        }
        let groupNumber = numberOfObjects/2 + 1

        let _ = Entity(name: name, group: "Group \(groupNumber)")
        saveContext()
        self.entities = (fetchedResultsController.fetchedObjects as? [Entity]) ?? []

    }
    
    
    func randomizeGroups() {
      
        let shuffledEntities = shuffleArray(&self.entities)
        
       // var groupNumber = 1
        var entityNumber = 0
      //  var tempNumberOfObjects = numberOfObjects
        for entity in shuffledEntities {
            
            entity.group = "Group \(entityNumber/2 + 1)"
            entityNumber += 1
            
        }
    
        
    }
    
    func shuffleArray(inout newEntities: [Entity]) -> [Entity]
    {
        for var index = newEntities.count - 1; index > 0; index -= 1
        {
            // Random int from 0 to index-1
            let j = Int(arc4random_uniform(UInt32(index-1)))
            
            // Swap two array elements
            // Notice '&' required as swap uses 'inout' parameters
            swap(&newEntities[index], &newEntities[j])
        }
        return newEntities
    }
    
    func deleteEntity(entity: Entity) {
        moc.deleteObject(entity)
        saveContext()
    }
    
    func saveContext() {
        do {
            try moc.save()
        } catch let error as NSError {
            print("Couldn't save to Context. Error: \(error.localizedDescription)")
        }
        
    }
    
    
    
}