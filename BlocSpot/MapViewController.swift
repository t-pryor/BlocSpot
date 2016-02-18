//
//  MapViewController.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-02-07.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 2000
    
    // &* declaring variables
    //var searchResults: MKLocalSearchResponse? = nil
    var searchResults = MKLocalSearchResponse()
    
    // controller-level scope to keep UISearchController in mem after it's created
    var searchResultsController: UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  setupSearchController()
        
        let locationSearchTable = storyboard!.instantiateViewControllerWithIdentifier("LocationSearchTable") as! LocationSearchTable
        locationSearchTable.mapView = mapView
        searchResultsController = UISearchController(searchResultsController: locationSearchTable)
        searchResultsController?.searchResultsUpdater = locationSearchTable
        
        
        
        let searchBar = searchResultsController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = searchResultsController?.searchBar
        
        self.definesPresentationContext = true
        
        K.store.setUpLocationManager()
        let initialLocation = K.store.getCurrentLocation()
        
        //let honoluluLocation = CLLocation(latitude: 21.282778, longitude: -157.8294444)

        
        if let initialLocation = initialLocation {
            centerMapOnLocation(initialLocation)
        } else {
           // centerMapOnLocation(honoluluLocation)
        }
        
        // determines whether the Navigation Bar disappears when the search results are shown
        searchResultsController?.hidesNavigationBarDuringPresentation = false
        // gives the modal overlay a semi-transparent background when the search bar is selected
        searchResultsController?.dimsBackgroundDuringPresentation = true
        //limits the overlap area to just the VC's frame instead of the whole nav controller
        definesPresentationContext = true
        
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated:true)
    }
}


extension MapViewController: UISearchBarDelegate, UISearchControllerDelegate/*, UISearchResultsUpdating*/ {
    
    func setupSearchController() {
        
        // the TableVC used to display the results of a search
        let searchResultsController = UITableViewController()
        searchResultsController.automaticallyAdjustsScrollViewInsets = false
        searchResultsController.tableView.dataSource = self
        searchResultsController.tableView.delegate = self

        
        // Initialize UISearchController-> should this be instance variable?
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.delegate = self
        searchController.searchBar.delegate = self
      //  searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.searchBarStyle = UISearchBarStyle.Minimal
        self.navigationItem.titleView = searchController.searchBar
        
        
        

    }

}
    
extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.mapItems.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchResultsCell", forIndexPath: indexPath)
        let item = searchResults.mapItems[indexPath.row]
        
        cell.textLabel?.text = item.placemark.name
        cell.detailTextLabel?.text = item.placemark.addressDictionary?["Street"] as? String
        
        return cell
        
        
    }
}

extension MapViewController: MKMapViewDelegate {
 // responsible for managing annotations

    
}

