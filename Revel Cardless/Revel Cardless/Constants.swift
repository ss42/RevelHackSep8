//
//  Constants.swift
//  test
//
//  Created by Sanjay Shrestha on 9/8/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import Foundation
import UIKit

struct Constants{
    struct Segues {
        static let distanceToStore = "distanceToStoreView"
        static let menuPage = "menuView"
        static let pumpPage = "pumpPage"
        static let chooseFuel = "chooseFuelView"
        static let beginFuelingPage = "beginFuelingPage"
        
        
       
        
    }
    
    struct Colors {
        static let darkBlue = UIColor(red: 0 , green: 133, blue: 193, alpha: 1.0)
        static let lightBlue = UIColor(red: 25, green: 142, blue: 202, alpha: 1.0)
        static let background = UIColor(red: 252, green: 252, blue: 252, alpha: 1.0)
    }
    
}

// TO SEGUE
//let vc: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier(Constants.Segues.menuPage)
//
//
//self.presentViewController(vc, animated: true, completion: nil)

class Customer{
    var name:String?
    var creditDigits:String?
    var phoneNumber:String?
    var email:String?
}

class Order{
    var customer:Customer?
    var orderArray:[DummyItems]?
    var total:Double?
}

class DummyItems{
    var name:String?
    var price:String?
    var discount:String?
}

