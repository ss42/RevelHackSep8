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
    var data:NSString?

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
        //let objectJSON = savePOST()
        //let objectJSON = prepareValidation()
        let objectJSON = makeSaleString()
        print(objectJSON)
        
        do {
            
            data = objectJSON
            
            
            let request = NSMutableURLRequest(URL: NSURL(string: "https://team5-hackathon.revelup.com/specialresources/cart/submit/")!)
            request.HTTPMethod = "POST"
            request.addValue("d5c40495e6c744f79c999722e25764fb:038b36255e114458adc02ca87602c7a8b0219cf8aef2461faa977b4107454be6", forHTTPHeaderField: "API-AUTHENTICATION")
            request.addValue("application/json", forHTTPHeaderField:"Content-type")
            print(request.mainDocumentURL)
            //let postString = "api_key=d5c40495e6c744f79c999722e25764fb&api_secret=038b36255e114458adc02ca87602c7a8b0219cf8aef2461faa977b4107454be6"
            //request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            request.HTTPBody = data?.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                
                
                
                if let httpStatus = response as? NSHTTPURLResponse  {           // check for http errors
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
/*
 
 
 "skin": "weborder",
 "establishmentId": 2,
 "items": [
 {
 
 "special_request": "",
 "price": 12,
 "product": 301,
 "product_name_override": "GreenPepper",
 "quantity": 1
 } ],
 "orderInfo": {
 "created_date": "2016-08-30T20:49:28",
 "pickup_time": "2016-08-30T22:00:00",
 "dining_option": 2,
 "notes": "",
 "asap": false,
 "customer": {
 "address": {
 "address": "1234 Kearny St., 3B, San Francisco, CA, 94133",
 "city": "San Francisco",
 "country": "US",
 "province": "",
 "state": "CA",
 "street_1": "1234 Kearny St.",
 "street_2": "3B",
 "zipcode": "94133"
 },
 "phone": "4155555555",
 "email": "dsmith@fakeemail.com",
 "first_name": "Dan",
 "last_name": "Smith"
 },
 "call_name": "Dan Smith / Aug 30, 15:00 / 4155555555"
 },
 "paymentInfo": {
 "tip": 0,
 "type": 7
 }
 }'*/

/*
func prepareValidation()->NSString{
    let objectJSON:Dictionary<String,NSObject> =
        [
        "skin":"weborder",
        "establishment":1,
        "items":
            [
                ["special_request": "",
                    "price": 12,
                    "product": 301,
                    "product_name_override": "GreenPepper",
                    "quantity": 1
                ]
            ],
        ["orderInfo":
            [
            "created_date": "2016-08-30T20:49:28",
            "pickup_time": "2016-08-30T22:00:00",
            "dining_option": 2,
            "notes": "",
            "asap": false,
            "customer":
                [
                "address":
                    [
                    "address": "1234 Kearny St., 3B, San Francisco, CA, 94133",
                    "city": "San Francisco",
                    "country": "US",
                    "province": "",
                    "state": "CA",
                    "street_1": "1234 Kearny St.",
                    "street_2": "3B",
                    "zipcode": "94133"
                    ],
                "phone": "4155555555",
                "email": "dsmith@fakeemail.com",
                "first_name": "Dan",
                "last_name": "Smith"
                ],
            "call_name": "Dan Smith / Aug 30, 15:00 / 4155555555"
            ],
            "paymentInfo": [
            "tip": 0,
            "type": 7
            ]
            ]
    ]
 
}
*/

func prepareValidation() -> NSString{
    let objectJSON: Dictionary<String, NSObject> = [
        "skin":"weborder",
        "establishment":1,
        "items":
            [
                [
                    "special_request": "",
                    "price": 1.4600,
                    "product": 432,
                    "product_name_override": "Regular",
                    "quantity": 1
                ]
        ],
        "orderInfo":
            [
                "created_date": "2016-08-30T20:49:28",
                //"pickup_time": "2016-08-30T22:00:00",
                "dining_option": 2,
                "notes": "",
                "asap": false,
                "customer":
                    [
                        "address":
                            [
                                "address": "1234 Kearny St., 3B, San Francisco, CA, 94133",
                                "city": "San Francisco",
                                "country": "US",
                                "province": "",
                                "state": "CA",
                                "street_1": "1234 Kearny St.",
                                "street_2": "3B",
                                "zipcode": "94133"
                        ],
                        "phone": "4155555555",
                        "email": "dsmith@fakeemail.com",
                        "first_name": "Dan",
                        "last_name": "Smith"
                ],
                "call_name": "Dan Smith / Aug 30, 15:00 / 4155555555"
        ],
        "paymentInfo":
            [
                "tip": 0,
                "type": 7
        ]
    ]
    
    var submitJSON: NSString = ""
    if NSJSONSerialization.isValidJSONObject(objectJSON) {
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(objectJSON, options: .PrettyPrinted)
            submitJSON = NSString(data: jsonData, encoding: NSUTF8StringEncoding)!
        } catch {
            //some exception handling goes here
        }
    }
    print(submitJSON)
    return submitJSON
}


func makeSaleString()-> NSString{
    let objectJSON: Dictionary<String, NSObject> =
        [
        "skin": "weborder",
        "establishmentId": 1,
        "items":
            [
                [
                    "special_request": "",
                    "price": 1.4600,
                    "product": 432,
                    "product_name_override": "Regular",
                    "quantity": 1
                ]
        ],
        "orderInfo":
            [
                "created_date": "2016-08-30T20:49:28",
                //"pickup_time": "2016-08-30T22:00:00",
                "dining_option": 0,
                "notes": "",
                "asap": false,
                "customer":
                    [
                        "address":
                            [
                                "address": "1234 Kearny St., 3B, San Francisco, CA, 94133",
                                "city": "San Francisco",
                                "country": "US",
                                "province": "",
                                "state": "CA",
                                "street_1": "1234 Kearny St.",
                                "street_2": "3B",
                                "zipcode": "94133"
                        ],
                        "phone": "4155555555",
                        "email": "dsmith@fakeemail.com",
                        "first_name": "Dan",
                        "last_name": "Smith"
                ],
                "call_name": "Dan Smith / Aug 30, 15:00 / 4155555555"
        ],
        "paymentInfo":
            [
                "amount": "17.88",
                "tip": 0,
                "type": 7,
                "transaction_id": ""
        ]
    ]
    
    var submitJSON: NSString = ""
    if NSJSONSerialization.isValidJSONObject(objectJSON) {
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(objectJSON, options: .PrettyPrinted)
            submitJSON = NSString(data: jsonData, encoding: NSUTF8StringEncoding)!
        } catch {
            //some exception handling goes here
        }
    }
    print(submitJSON)
    return submitJSON
    
    
}


func savePOST() -> NSString {
    let objectJSON: Dictionary<String, NSObject> =
        [
            "establishment":1,
            "items":
                [
                    [
                        
                        "special_request": "",
                        "price": 1.4600,
                        "product": 432,
                        "product_name_override": "Regular",
                        "quantity": 100
                    ]
            ],
            "orderInfo":
                [
                    "dining_option": 0
            ]
    ]
    
    var submitJSON: NSString = ""
    if NSJSONSerialization.isValidJSONObject(objectJSON) {
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(objectJSON, options: .PrettyPrinted)
            submitJSON = NSString(data: jsonData, encoding: NSUTF8StringEncoding)!
        } catch {
            //some exception handling goes here
        }
    }
    print(submitJSON)
    return submitJSON
}


/*
func savePOST() -> NSData {
    /*let objectJSON: Dictionary<String, NSObject> =
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
    ]*/
    
    

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
}*/
