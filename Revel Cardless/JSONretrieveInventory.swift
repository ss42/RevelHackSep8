//
//  JSONretrieveInventory.swift
//  Revel Cardless
//
//  Created by Sanjay Shrestha on 9/9/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import Foundation
import UIKit

struct Promotion_product {
    var product_name: String?
    var product_category: Int?
    var product_price: Double?
    var product_discount: Double?
    
    init(product_name: String, product_category: Int, product_price: Double, product_discount: Double) {
        self.product_name = product_name
        self.product_category = product_category
        self.product_price = product_price
        self.product_discount = product_discount
    }
}

struct Inventory_product {
    var item_name: String?
    var item_price: Double?
    
    init(item_name: String, item_price: Double) {
        self.item_name = item_name
        self.item_price = item_price
    }
}

class JSONinventoryParser {
    var promotelist: [Promotion_product]?
    var inventorylist: [Inventory_product]?
    
    func runPromotionJSONparser(){
        sendRequest("https://team5-hackathon.revelup.com/weborders/products", parameters: ["api_key":"d5c40495e6c744f79c999722e25764fb","api_secret":"038b36255e114458adc02ca87602c7a8b0219cf8aef2461faa977b4107454be6","establishment":"1"], completionHandler: {a,b,c in
            
            let data = a!
            
            do {
                let object = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    dispatch_async(dispatch_get_main_queue(),{
                    self.promotelist = self.readPromotionJSONobject(dictionary)
                        print(self.promotelist?.count)
//                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                        appDelegate.promotionArray = self.in!
                    })
                    
                }
            } catch {
                print("error") //exception handling goes here, "error" for now; need sophisticated exception handling implementation
            }
            
        })
    }
    
    func runInventoryJSONparser() {
        sendRequest("https://team5-hackathon.revelup.com/weborders/products", parameters: ["api_key":"d5c40495e6c744f79c999722e25764fb","api_secret":"038b36255e114458adc02ca87602c7a8b0219cf8aef2461faa977b4107454be6","establishment":"1"], completionHandler: {a,b,c in
            
            let data = a!
            
            do {
                let object = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    //dispatch_async(dispatch_get_main_queue(),{
                    //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    //appDelegate.pumpList = self.pumplist!
                    //})
                    dispatch_async(dispatch_get_main_queue(),{
                        self.inventorylist = self.readInventoryJSONobject(dictionary)

                      //  self.promotelist = self.readPromotionJSONobject(dictionary)
                       // print(self.promotelist?.count)
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.promotionArray = self.inventorylist!
                    })
                    
                    
                }
            } catch {
                print("error") //exception handling goes here, "error" for now; need sophisticated exception handling implementation
            }
            
        })
        
    }
    
    func sendRequest(url: String, parameters: [String: AnyObject], completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionTask {
        let parameterString = parameters.stringFromHttpParameters()
        let requestURL = NSURL(string:"\(url)?\(parameterString)")!
        
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler:completionHandler)
        task.resume()
        
        return task
    }
    
    func readPromotionJSONobject(object: [String: AnyObject]) -> [Promotion_product] {
        
        var inventorylist: [Promotion_product] = []
        
        let newobject = object["data"] as! [[String: AnyObject]]
        
        for item in newobject {
            if item["id_category"] as! Int == 95 {
                let tempPromote = Promotion_product(product_name: String(item["name"]!), product_category: item["id_category"] as! Int, product_price: item["price"] as! Double, product_discount: 0.15)
                inventorylist.append(tempPromote)
            }
        }
        
        return inventorylist
    }
    
    func readInventoryJSONobject(object: [String: AnyObject]) -> [Inventory_product] {
        
        var inventorylist: [Inventory_product] = []
        
        let newobject = object["data"] as! [[String: AnyObject]]
        
        for item in newobject {
            if item["id_category"] as! Int != 138 {
                let tempInventory = Inventory_product(item_name: String(item["name"]!), item_price: item["price"] as! Double)
                inventorylist.append(tempInventory)
            }
        }
        
        return inventorylist
    }
    
}