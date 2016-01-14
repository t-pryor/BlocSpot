////
////  Search.swift
////  BlocSpot
////
////  Created by Tim Pryor on 2016-01-07.
////  Copyright © 2016 Tim Pryor. All rights reserved.
////
//
//import Foundation
//import MapKit
//
//
//func ==(lhs: SearchSpots, rhs: SearchSpots) -> Bool {
//    return (lhs.pointOfInterest.title == rhs.pointOfInterest.title)
//}
//
//// &* should this be a struct or a class?
//// must be very careful about using a ref type inside a value type
//
//class SearchSpots: Equatable {
//    var pointOfInterest = POI()
//    var localSearch: MKLocalSearch
//    var localSearchRequest: MKLocalSearchRequest
//
//    
////---
//    init(query: String, region: MKCoordinateRegion) {
//        
//        self.localSearchRequest = MKLocalSearchRequest()
//        self.localSearchRequest.naturalLanguageQuery = query
//        self.localSearchRequest.region = region
//        
//        self.localSearch = MKLocalSearch(request: localSearchRequest)
//    }
//  
////---
//    func searchForResults() {
//        print("in searchForResults()")
//        let custConcurrentQ = dispatch_queue_create("com.example", DISPATCH_QUEUE_CONCURRENT)
//        
//        self.localSearch.startWithCompletionHandler({
//            
//            (response: MKLocalSearchResponse?, error: ErrorType?) in
//            
//            dispatch_barrier_async(custConcurrentQ) {
//            
//            if let resp = response {
//                if error != nil {
//                    print("error occured")
//                
//                } else if resp.mapItems.count == 0 {
//                    print("No matches found")
//                } else {
//                    print("matches found")
//                    
//                    for item in resp.mapItems {
//                        print("Name = \(item.name)")
//                        print("Phone = \(item.phoneNumber)")
//                        self.pointOfInterest.title = item.name!
//                    }
//                }
//            }
//            
//            
//            
//            }
//            
//        })//END BARRIER
//        
//        print(" -------------NAME----------- \(self.pointOfInterest.title)")
//        
//    }
//    
//    func addSearchToHistory() {
//        
//        
//        
//        
//        
//        
//    }
//    
//
////    var localSearchRequest: MKLocalSearchRequest
////    var localSearch: MKLocalSearch
////    
////    init(request: MKLocalSearchRequest) {
////
////    }
//    
//    
//
//
//
//}
//
///*
//
//// Create and initialize a search request object.
//MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
//request.naturalLanguageQuery = query;
//request.region = self.map.region;
//
//// Create and initialize a search object.
//MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
//
//// Start the search and display the results as annotations on the map.
//[search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
//{
//NSMutableArray *placemarks = [NSMutableArray array];
//for (MKMapItem *item in response.mapItems) {
//[placemarks addObject:item.placemark];
//}
//[self.map removeAnnotations:[self.map annotations]];
//[self.map showAnnotations:placemarks animated:NO];
//}];
//
//
//
//
//
//*/