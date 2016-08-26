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
    }
    
    func addEntity(name: String) {
        
//        if numberOfObjects%2 != 0 {
//        } else {
//            let groupNumber = numberOfObjects/2
//        }
        let groupNumber = numberOfObjects/2 + 1

        let _ = Entity(name: name, group: "Group \(groupNumber)")
        saveContext()
    }
    
    func randomizeGroups 
    
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