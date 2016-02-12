//
//  SpotInfo.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-02-06.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

struct SpotInfo {

    let name: String?
    var phoneNumber: String?
    var latitude: Double?
    var longitude: Double?
    
    init(name: String?, phoneNumber: String?, latitude: Double, longitude: Double) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.latitude = latitude
        self.longitude = longitude
    }
   
    static func convertPlacemarkCoordinatesToLatitudeAndLongitude(placemark: MKPlacemark) -> (Double, Double) {
        let latitude = placemark.coordinate.latitude
        let longitude = placemark.coordinate.longitude
        
        return (latitude, longitude)
    }
    
//    http://code.tutsplus.com/tutorials/core-data-and-swift-subclassing-nsmanagedobject--cms-25116
}

