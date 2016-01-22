//
//  SearchTableViewController.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-01-21.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.initializeSearchController()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        self.searchController.active = true
        self.searchController.searchBar.userInteractionEnabled = true
        print(self.searchController.searchBar.becomeFirstResponder())
        

        
        
    }
    
    func initializeSearchController() {
     //   self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.sizeToFit()
        self.definesPresentationContext = true
        self.tableView.tableHeaderView = self.searchController.searchBar
        //self.searchController.active = true
      
        
        
    
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
