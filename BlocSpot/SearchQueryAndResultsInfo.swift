//
//  Search.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-02-08.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import CoreData
import MapKit

struct SearchQueryAndResults {

    var query: String
    var region: MKCoordinateRegion
    var searchSpotsResults: [SpotInfo]

}

