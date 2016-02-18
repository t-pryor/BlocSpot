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
    
    func parseAddress(selectedItem: MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/stae
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil ? " " : "")
        
        let addressLine = String(format: "%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
    
        return " "
    }
    
    
    
}

extension LocationSearchTable: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        guard let mapView = mapView, let searchBarText = searchController.searchBar.text else {
            return
        }
        
        let completionClosure = { (results: Array<MKMapItem>)  -> () in
            self.matchingItems = results
            self.tableView.reloadData()
        }
        
        K.store.searchQuery(searchBarText, region: mapView.region, completionClosure: completionClosure)
        
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