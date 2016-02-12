//
//  MapViewController.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-02-07.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
   // private let searchResultsTableViewController //= UITableViewController()
    //private let searchController: UISearchController//(searchResultsController: nil)
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        
        let searchResultsTableViewController = UITableViewController()
        let searchController = UISearchController(searchResultsController: searchResultsTableViewController)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.searchBarStyle = UISearchBarStyle.Minimal
        self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
        
        searchResultsTableViewController.tableView.dataSource = self
        searchResultsTableViewController.tableView.delegate = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        
       // self.initializeSearchController()
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        print("foo")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    /*

    
    searchResultsController.tableView.dataSource = self;
    searchResultsController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    
    
    
    @implementation UIViewControllerSubclass
    
    - (void)viewDidLoad
    {
    [super viewDidLoad];
    // Do any custom init from here...
    
    // Create a UITableViewController to present search results since the actual view controller is not a subclass of UITableViewController in this case
    UITableViewController *searchResultsController = [[UITableViewController alloc] init];
    
    // Init UISearchController with the search results controller
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    
    // Link the search controller
    self.searchController.searchResultsUpdater = self;
    
    // This is obviously needed because the search bar will be contained in the navigation bar
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    // Required (?) to set place a search bar in a navigation bar
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    // This is where you set the search bar in the navigation bar, instead of using table view's header ...
    self.navigationItem.titleView = self.searchController.searchBar;
    
    // To ensure search results controller is presented in the current view controller
    self.definesPresentationContext = YES;
    
    // Setting delegates and other stuff
    searchResultsController.tableView.dataSource = self;
    searchResultsController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;        
    }

*/
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
//        self.searchController.active = true
//        self.searchController.searchBar.userInteractionEnabled = true
//        print(self.searchController.searchBar.becomeFirstResponder())
//        
//        
//        
//        
    }
    
    func initializeSearchController() {
//        //   self.searchController.searchResultsUpdater = self
//        self.searchController.dimsBackgroundDuringPresentation = false
//        self.searchController.delegate = self
//        self.searchController.searchBar.delegate = self
//        self.searchController.searchBar.sizeToFit()
//        self.definesPresentationContext = true
//        self.navigationItem.titleView = self.searchController.searchBar
//        self.searchController.active = true
//        
    }
    
    
}
