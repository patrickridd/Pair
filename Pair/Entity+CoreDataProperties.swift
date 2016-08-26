//
//  Entity+CoreDataProperties.swift
//  Pair
//
//  Created by Patrick Ridd on 8/26/16.
//  Copyright © 2016 PatrickRidd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Entity {

    @NSManaged var name: String?
    @NSManaged var group: String?

}
