//
//  Entity.swift
//  Pair
//
//  Created by Patrick Ridd on 8/26/16.
//  Copyright © 2016 PatrickRidd. All rights reserved.
//

import Foundation
import CoreData


class Entity: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    convenience init(name: String, managedObjectContext: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Entity", inManagedObjectContext: managedObjectContext)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
        
        self.name = name
        
    }
    
    
}
