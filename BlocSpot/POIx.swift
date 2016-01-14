//
//  POI.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-01-08.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import Foundation
import MapKit

/*

Need to inherit from NSObject in order to conform to MKAnnotation protocol, so POI must be a class, not a struct
To implement the MKAnnotation protocol a class must implement the coordinate property
Used by the map view to determine where the annotation should b placed on the map
*/
//
//class POI: NSObject, MKAnnotation {
//    var title: String?
//    var subtitle: String?
//    var coordinate: CLLocationCoordinate2D
//    
//    override init() {
//        self.title = ""
//        self.subtitle = ""
//        self.coordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
//    }
//    
//    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
//        self.title = title
//        self.subtitle = subtitle
//        self.coordinate = coordinate
//    }
//    
//    
//    
//    
//}
