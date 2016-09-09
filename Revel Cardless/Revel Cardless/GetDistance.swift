//
//  GetDistance.swift
//  test
//
//  Created by Rui Li on 9/8/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import Foundation
import MapKit

class getDistance {
    
    class func getDistance(startLocationLatitude: Double, startLocationLongitude: Double, distinationLocationLatitude: Double, distinationLocationLongitude: Double) -> Double {
        var routeDistance:Double = 0;
        let directionRequest = MKDirectionsRequest()
        //set up the d
        let sourceCoord = CLLocationCoordinate2D(latitude: startLocationLatitude, longitude: startLocationLongitude)
        let destinationCoord = CLLocationCoordinate2D(latitude: distinationLocationLatitude, longitude: distinationLocationLongitude)
        let mkPlacemarkOrigen = MKPlacemark(coordinate: sourceCoord, addressDictionary: nil)
        let mkPlacemarkDestination = MKPlacemark(coordinate: destinationCoord, addressDictionary: nil)
        let source:MKMapItem = MKMapItem(placemark: mkPlacemarkOrigen)
        let destination:MKMapItem = MKMapItem(placemark: mkPlacemarkDestination)
        directionRequest.source =  source
        directionRequest.destination = destination
        let directions = MKDirections(request: directionRequest)
        directions.calculateDirectionsWithCompletionHandler {
            (response, error) -> Void in
            if error != nil { print("Error calculating direction - \(error!.localizedDescription)") }
            else {
                for route in response!.routes{
                    print("Distance = \(route.distance)")
                    routeDistance = route.distance
                    for step in route.steps{
                        print(step.instructions)
                    }  
                }
            }
        }
    
    
        return routeDistance
    }
}
