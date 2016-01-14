//
//  POITests.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-01-13.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import XCTest
@testable import BlocSpot
import CoreData

class SpotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
//---
    func testCreatingSpot() {
        
       // let testSpot = Spot(title: "McDonalds", subtitle: "99 Billion Served", latitude: 45, longitude: 45, category: .Restaurants)
        let testSpot = LocationDataSource.sharedInstance.createSpotWithTitle("McDonalds", subtitle: "99 Billion Served", latitude: 45, longitude: 45, category: .Restaurants)
        
        print(LocationDataSource.sharedInstance.allSpots)
        
        
//        
//        
        
    }
    
    
//---
    func testSavingPOI() {
       
        
    }
    
    

    
    
    
    
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
