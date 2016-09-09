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
    
    var distanceAway = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    // variable that stores the price data
    // make sure use  String(format: "%.2f", xxxx) to limit the decimal places
    // if the price is -1 it means there is no such fuel type in the gas station
    var gasTypesAndPrice:[String : Double] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //init
        initGasTypesAndPrice()
        // origin:
        // latitude, longitude
        // 37.796980, -122.405078
        // distination:
        // 1800 Lombard Street, San Francisco, CA
        // 37.800705, -122.431450
        let routeDistance = GetDistance.getDistance(37.796980, startLocationLongitude: -122.405078, distinationLocationLatitude: 37.800705, distinationLocationLongitude: -122.431450)
        print("routeDistance = \(routeDistance)")
        // Do any additional setup after loading the view, typically from a nib.
        //weborders/menu/?establishment=2'
        sendRequest("https://team5-hackathon.revelup.com/weborders/products", parameters: ["api_key":"d5c40495e6c744f79c999722e25764fb","api_secret":"038b36255e114458adc02ca87602c7a8b0219cf8aef2461faa977b4107454be6","establishment":"1"], completionHandler: {a,b,c in
        
        let data = a!
        
        do {
        let object = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        if let dictionary = object as? [String: AnyObject] {
        //print(dictionary.keys.count)
        self.readJSONobject(dictionary)
        }
        } catch {
        print("error") //exception handling goes here, "error" for now; need sophisticated exception handling implementation
        }
        
        })
    
    }
    // simply init GasTypesAndPrice
    func initGasTypesAndPrice() {
        gasTypesAndPrice = [
            "Regular":-1,
            "Premium":-1,
            "Diesel":-1,
            "CNG":-1,
            "LPG":-1,
            "Premium Plus":-1
        ]
    }
    func sendRequest(url: String, parameters: [String: AnyObject], completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionTask {
        let parameterString = parameters.stringFromHttpParameters()
        let requestURL = NSURL(string:"\(url)?\(parameterString)")!
        
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        print (requestURL.absoluteString)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler:completionHandler)
        task.resume()
        
        return task
    }
    
    func readJSONobject(object: [String: AnyObject]) { //break into smaller dictionaries
        let jasonObject = object["data"] as! [[String: AnyObject]]
        //newObject = newObject["categories"] as! [String: AnyObject]
        //let temp = newObject[0]
        for jsonItems in jasonObject{
            //print(jsonItems["name"]!)
            for(type, _) in gasTypesAndPrice{
                let name = (jsonItems["name"]!) as! String
                if name == type {
                    let price = jsonItems["price"]
                    gasTypesAndPrice.updateValue(price as! Double, forKey: name)
                }
            }
        }
        print(gasTypesAndPrice)
        print(object)
        //newObject =
        //print(newObject);
    }


    func getDistance(startLocationLatitude: Double, startLocationLongitude: Double, distinationLocationLatitude: Double, distinationLocationLongitude: Double) -> Double {
        var routeDistance:Double = 0;
        let directionRequest = MKDirectionsRequest()
        //set up the distination coordination
        let sourceCoord = CLLocationCoordinate2D(latitude: startLocationLatitude, longitude: startLocationLongitude)
        let destinationCoord = CLLocationCoordinate2D(latitude: distinationLocationLatitude, longitude: distinationLocationLongitude)
        let mkPlacemarkOrigen = MKPlacemark(coordinate: sourceCoord, addressDictionary: nil)
        let mkPlacemarkDestination = MKPlacemark(coordinate: destinationCoord, addressDictionary: nil)
        let source:MKMapItem = MKMapItem(placemark: mkPlacemarkOrigen)
        let destination:MKMapItem = MKMapItem(placemark: mkPlacemarkDestination)
        //set up directionRequest
        directionRequest.transportType = .Automobile
        directionRequest.source =  source
        directionRequest.destination = destination
        let directions = MKDirections(request: directionRequest)
        directions.calculateDirectionsWithCompletionHandler {
            (response, error) -> Void in
            if error != nil { print("Error calculating direction - \(error!.localizedDescription)") }
            else {
                for route in response!.routes{
                    print("Distance = \(route.distance)")
                    self.distanceAway = Int(route.distance * 0.621371)
                    routeDistance = route.distance
                    for step in route.steps{
                        print(step.instructions)
                    }
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
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier(Constants.Segues.menuPage)
        
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: GasStationsTableViewCell = tableView.dequeueReusableCellWithIdentifier("StoreCell") as! GasStationsTableViewCell
        
        cell.storeDetail.text = "Shell @ 1800 Lombard Street" + " " + "1.84 miles away"
        cell.price.text = "$2.61"
        return cell
    }
    


}

