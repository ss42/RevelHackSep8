//
//  BeginFuelingViewController.swift
//  test
//
//  Created by Sanjay Shrestha on 9/8/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import UIKit

class BeginFuelingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let total = 5
        let totalData = JSONsendTransaction()
        //let priceData = totalData.getPrice(5)
        if totalData.prepareDataForPriceCheck(5)
        {
            print("ok im ready to buy some gas!")
        }
        
        if totalData.prepareDataForValidation()
        {
            print("ok the data is ready to roll!")
        }
        if totalData.prepareDataForSale()
        {
            print("ok we have sold it!!!")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func seekAssistance(sender: AnyObject) {
        alertShow("Notified", message: "Please wait for the Attendent!")
    }
    func performSegue(segueName: String){
        let vc: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier(segueName)
        
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func alertShow(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel){(action)-> Void in
            print("oka")
            
            
        }
        alert.addAction(action)
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
