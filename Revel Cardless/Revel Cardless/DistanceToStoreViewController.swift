//
//  ViewController.swift
//  test
//
//  Created by Sanjay Shrestha on 9/8/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import UIKit
import MapKit

class DistanceToStoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var distanceAway:Double = 0
    
    var pumpList = [Pump]()
    
    var shellLocations = ["Shell @ 1800 Lombard Street" + " " + "1.84 miles away", "Shell @ 100 Market Street" + " " + "3.84 miles away", "Shell @ 231 Mason Street" + " " + "3.44 miles away", "Shell @ 230 Broadway Street" + " " + "3.44 miles away"]
    var shellPrice = ["$2.61", "$2.22", "$2.61", "$3.01"]
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // origin:
        // latitude, longitude
        // 37.796980, -122.405078
        // distination:
        // 1800 Lombard Street, San Francisco, CA
        // 37.800705, -122.431450
        let routeDistance = self.getDistance(37.796980, startLocationLongitude: -122.405078, distinationLocationLatitude: 37.800705, distinationLocationLongitude: -122.431450);
        print("routeDistance = \(routeDistance)")
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    func getDistance(startLocationLatitude: Double, startLocationLongitude: Double, distinationLocationLatitude: Double, distinationLocationLongitude: Double) -> Double {
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
                    if(route.distance>0){
                        //routeDistance = route.distance
                        self.distanceAway = route.distance
                    }
                    /**
                     for step in route.steps{
                     print(step.instructions)
                     } **/
                }
            }
        }
        
        
        return routeDistance
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier(Constants.Segues.menuPage)
        
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: GasStationsTableViewCell = tableView.dequeueReusableCellWithIdentifier("StoreCell") as! GasStationsTableViewCell
        
        cell.storeDetail.text = shellLocations[indexPath.row]
        cell.price.text = shellPrice[indexPath.row]
        return cell
    }
    
    

    


}

