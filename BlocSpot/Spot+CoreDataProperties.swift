//
//  Spot+CoreDataProperties.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-01-13.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Spot {
    
    @objc enum Category: Int32
    {
        case Restaurants    = 0
        case Bars           = 1
        case Stores         = 2
        case TouristTraps   = 3
        case Undefined      = 4
    }

    @NSManaged var title: String?
    @NSManaged var subtitle: String?
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var category: Category

    
    convenience init(title: String?, subtitle: String?, latitude: Double?, longitude: Double?, category: Category ) {
        
        
        let entity = NSEntityDescription.entityForName("Spot",
            inManagedObjectContext: LocationDataSource.sharedInstance.managedObjectContext)
                    // do I need forced unwrapping here? Is there an alternative?
                    // can't use if let as designated initializer not guaranteed to be called
                self.init(entity: entity!, insertIntoManagedObjectContext: LocationDataSource.sharedInstance.managedObjectContext)

                self.title = title
                self.subtitle = subtitle ?? "No subtitle"
                self.latitude = latitude ?? -1
                self.longitude = longitude ?? -1
                self.category = category
        

    }

}
