//
//  Spot.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-01-13.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import Foundation
import CoreData
import MapKit

class Spot: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    static func convertPlacemarkCoordinatesToLatitudeAndLongitude(placemark: MKPlacemark) -> (Double, Double) {
        let latitude = placemark.coordinate.latitude
        let longitude = placemark.coordinate.longitude
        
        return (latitude, longitude)
    }
    
}
