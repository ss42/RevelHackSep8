//
//  ChoosePaymentForAdvanceViewController.swift
//  Revel Cardless
//
//  Created by Sanjay Shrestha on 9/9/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import UIKit

class ChoosePaymentForAdvanceViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func performSegue(segueName: String){
        let vc: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier(segueName)
        
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func confirmPayment(sender: AnyObject) {
        alertShow("Your Payment went through!", message: "Thank you for using Shell!")
        
    }
    
    
    
    @IBAction func backPressed(sender: AnyObject) {
        performSegue(Constants.Segues.advancePayPage)
    }
    
    func alertShow(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel){(action)-> Void in
            self.performSegue(Constants.Segues.distanceToStore)
        }
        alert.addAction(action)
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    func okayClicked(){
        
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
