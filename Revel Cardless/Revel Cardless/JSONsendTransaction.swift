//
//  JSONsendTransaction.swift
//  Revel Cardless
//
//  Created by Sanjay Shrestha on 9/9/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import Foundation

class JSONsendTransaction{
/*establishmentId": 2,
"items": [
{
"modifieritems": [
{
"modifier": 40,
"modifier_cost": 0.5,
"modifier_price": 1.5,
"qty": 1,
"qty_type": 0,
"admin_mod_key": null
} ],
"special_request": "",
"price": 12,
"product": 301,
"product_name_override": "GreenPepper",
"quantity": 1
} ],
"orderInfo": {
    "dining_option": 0
}
}'*/
    var data:NSData?

    func sendRequest(url: String, parameters: [String: AnyObject], completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionTask {
        let parameterString = parameters.stringFromHttpParameters()
        let requestURL = NSURL(string:"\(url)?\(parameterString)")!
        
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "POST"
        
        //print (requestURL.absoluteString)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler:completionHandler)
        task.resume()
        
        return task
    }
    
    func prepareData(){
        /*let objectJSON = {"establishmentId": "2", "items": [{"modifieritems": [{"modifier": "40","modifier_cost": "0.5","modifier_price": "1.5","qty": 1,"qty_type": "0","admin_mod_key": NSNull()}],"special_request": "","price": "12","product": "301","product_name_override": "GreenPepper","quantity": 1}],"orderInfo":{"dining_option": "0"}}
 */
        let objectJSON = savePOST()
        
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(objectJSON, options: .PrettyPrinted)
            data = jsonData
            
            
            let request = NSMutableURLRequest(URL: NSURL(string: "https://team5-hackathon.revelup.com/specialresources/cart/calculate/")!)
            request.HTTPMethod = "POST"
            let postString = "api_key=d5c40495e6c744f79c999722e25764fb&api_secret = 038b36255e114458adc02ca87602c7a8b0219cf8aef2461faa977b4107454be6"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let responseString = String(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
            }
            task.resume()
            
            
        } catch {
            //some exception handling goes here
        }
    }

}





func savePOST() -> NSData {
    let objectJSON: Dictionary<String, NSObject> =
        [
            "establishment":2,
            "items":
                [
                    [
                        "modifieritems":
                            [
                                [
                                    "modifier":40,
                                    "modifier_cost": 0.5,
                                    "modifier_price": 1.5,
                                    "qty": 1,
                                    "qty_type": 0,
                                    "admin_mod_key": NSNull()
                                ]
                        ],
                        "special_request": "",
                        "price": 12,
                        "product": 301,
                        "product_name_override": "GreenPepper",
                        "quantity": 1
                    ]
            ],
            "orderInfo":
                [
                    "dining_option": 0
            ]
    ]
    
    var submitJSON:NSData?
    if NSJSONSerialization.isValidJSONObject(objectJSON) {
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(objectJSON, options: .PrettyPrinted)
            submitJSON = jsonData
        } catch {
            //some exception handling goes here
            print("test")
        }
    }
    return submitJSON!
}
