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
import CoreLocation

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
        if let entity = NSEntityDescription.entityForName("Spot",
            inManagedObjectContext: LocationDataSource.sharedInstance.managedObjectContext) {
            
            // this is defined on NSManagedObject: see BNR, chap 17, Spot inherits superclass's designated initializers
            self.init(entity: entity, insertIntoManagedObjectContext: LocationDataSource.sharedInstance.managedObjectContext)
            self.title = title
            self.subtitle = subtitle ?? "No subtitle"
            self.latitude = latitude ?? -1
            self.longitude = longitude ?? -1
            self.category = category
            
        } else {
            self.init()
        }
    }
    
    
    // should I do this here?
    func convertToLatitudeAndLongitude(coordinates: CLLocationCoordinate2D) -> (Double, Double) {
        let latitude = coordinates.latitude  // CLLocationDegrees is a Double
        let longitude = coordinates.longitude
        
        return (latitude, longitude)
    }
    
}
