//
//  SpotListDataProviderProtocol.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-02-06.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import UIKit
import CoreData

protocol SpotListDataProviderProtocol: UITableViewDataSource {
    
    var managedObjectContext: NSManagedObjectContext? { get set }
    weak var tableView: UITableView! { get set }
    
    // methods
    
    
}