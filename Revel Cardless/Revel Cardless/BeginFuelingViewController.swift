//
//  BeginFuelingViewController.swift
//  test
//
//  Created by Sanjay Shrestha on 9/8/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import UIKit

class BeginFuelingViewController: UIViewController {

    @IBOutlet weak var trackerLabel: UILabel!
    @IBOutlet weak var smallLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var leftPicture: UIImageView!
    @IBOutlet weak var activityViewIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var bottomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let total = 5
        let totalData = JSONsendTransaction()
        //let priceData = totalData.getPrice(5)
        if totalData.prepareDataForPriceCheck(5)
        {
            
            print("ok im ready to buy some gas!")
            
            mainLabel.text = "Please Wait!"
            mainLabel.adjustsFontSizeToFitWidth = true
            smallLabel.text = "Authorizing transaction!"
            smallLabel.adjustsFontSizeToFitWidth = true
            activityViewIndicator.startAnimating()
        }
        let t1 = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 5 * Int64(NSEC_PER_SEC))
        
         dispatch_after(t1, dispatch_get_main_queue()) {
            
            if totalData.prepareDataForValidation()
            {
                
                //self.mainLabel.text = "S!"
                self.mainLabel.adjustsFontSizeToFitWidth = true
                self.smallLabel.text = "Waiting on attendent to authorize your pump!"
                self.smallLabel.adjustsFontSizeToFitWidth = true
                self.activityViewIndicator.startAnimating()

                //mainLabel.text = "Five gallons of regular will run you: "
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 10 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue()) {
                    //put your code which should be executed with a delay here
                    self.smallLabel.text = "Finalizing transaction!"
                    self.activityViewIndicator.startAnimating()
                    if totalData.prepareDataForSale(){
                        dispatch_after(time, dispatch_get_main_queue()) {
                            self.mainLabel.text = "5.2 gallons of regular was $17.88 today!"
                            self.smallLabel.text = "Transaction Complete!"
                            self.activityViewIndicator.stopAnimating()
                            self.activityViewIndicator.hidesWhenStopped = true
                            //self.updateRewards()
                             dispatch_after(time, dispatch_get_main_queue()) {
                                self.updateRewards()
                            }
                        }
                    }
                }
                
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    func updateRewards(){
        self.bottomButton.setTitle("Done!", forState: .Normal)
        self.trackerLabel.text = "Loyalty Tracker(206/1000)!"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func seekAssistance(sender: AnyObject) {
        alertShow("Notified", message: "Please wait for the Attendent!")
    }
    
    
    @IBAction func donePressed(sender: AnyObject) {
        alertShow("Notified", message: "Please wait for the Attendent!")
    }
    func performSegue(segueName: String){
        let vc: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier(segueName)
        
        
        self.presentViewController(vc, animated: true, completion: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
