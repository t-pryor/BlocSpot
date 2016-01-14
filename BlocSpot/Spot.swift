//
//  Spot.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-01-13.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import Foundation
import CoreData


class Spot: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    init() {
        if let entity = NSEntityDescription.entityForName("Spot",
            inManagedObjectContext: LocationDataSource.sharedInstance.managedObjectContext) {
                super.init(entity: entity, insertIntoManagedObjectContext: LocationDataSource.sharedInstance.managedObjectContext)
                return
        }
        super.init()
        return
    }
}
