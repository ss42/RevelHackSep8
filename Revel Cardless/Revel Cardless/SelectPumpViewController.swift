//
//  SelectPumpViewController.swift
//  test
//
//  Created by Sanjay Shrestha on 9/8/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import UIKit

class SelectPumpViewController: UIViewController {

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
    
    @IBAction func goBackPressed(sender: AnyObject) {
        performSegue(Constants.Segues.menuPage)
        
        
    }
    @IBAction func pumpOnePressed(sender: AnyObject) {
        performSegue(Constants.Segues.chooseFuel)
        
    }
    @IBAction func pumpTwoPressed(sender: AnyObject) {
        
        
        
    }
    @IBAction func pumpThreePressed(sender: AnyObject) {
        
        
        
    }
    @IBAction func pumpFourPressed(sender: AnyObject) {
        
        
        
    }
    @IBAction func pumpFivePressed(sender: AnyObject) {
        
        
    }
    @IBAction func pumpSixPressed(sender: AnyObject) {
        
    }
    @IBAction func pumpSevenPressed(sender: AnyObject) {
        
    }
    @IBAction func pumpEightPressed(sender: AnyObject) {
        
        
    }
    @IBAction func pumpNinePressed(sender: AnyObject) {
        
        
    }
    @IBAction func pumpTenPressed(sender: AnyObject) {
        
        
    }
   

}
