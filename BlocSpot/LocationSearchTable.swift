//
//  LocationSearchTable.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-02-16.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UITableViewController {
    
    // use this to sotre search results
    var matchingItems: [MKMapItem] = []
    
    // search queries rely on a map region to prioritize local results
    // mapView var is a handle to the map from the previous screen
    var mapView: MKMapView? = nil
    
    
}

extension LocationSearchTable: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let mapView = mapView, let searchBarText = searchController.searchBar.text else {
            return
        }
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region

        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler{ response, error in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
        
        
//        let response = K.store.searchQuery(searchBarText, region: mapView.region)
//        print(response)  // &* Falko: always nil
//        
//        if let response = response {
//            matchingItems = response.mapItems
//            tableView.reloadData()
//
//        } else {
//            return
//        }
    
        
    }
    
}

extension LocationSearchTable {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = ""
        return cell
    }
    
    
}