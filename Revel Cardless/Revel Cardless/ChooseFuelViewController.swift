//
//  ChooseFuelViewController.swift
//  test
//
//  Created by Sanjay Shrestha on 9/8/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import UIKit

class ChooseFuelViewController: UIViewController {
    
    
    
    //MARK: IBOutlets
    @IBOutlet weak var tenPressed: UIButton!
    
    @IBOutlet weak var twentyPressed: UIButton!

    @IBOutlet weak var thirtyPressed: UIButton!
    
    @IBOutlet weak var fortyPressed: UIButton!
    
    @IBOutlet weak var openTabPressed: UIButton!
    
    @IBOutlet weak var othersPrepaidAmount: UITextField!

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
        
        performSegue(Constants.Segues.pumpPage)
    }
    
    
    
    //When you don't know how much you need
    @IBAction func openTabPressed(sender: UIButton) {
        othersPrepaidAmount.text = "Ready!"
        clearColors()
        sender.backgroundColor = UIColor.lightGrayColor()
        
    }

    @IBAction func tenPressed(sender: UIButton) {
        othersPrepaidAmount.text = "$10.00"
        clearColors()
        sender.backgroundColor = UIColor.lightGrayColor()
    }
    @IBAction func twentyPrepaidPressed(sender: UIButton) {
        clearColors()
        othersPrepaidAmount.text = "$20.00"
        sender.backgroundColor = UIColor.lightGrayColor()
        
    }
    @IBAction func thirtyPressed(sender: UIButton) {
        clearColors()
        othersPrepaidAmount.text = "$30.00"
        sender.backgroundColor = UIColor.lightGrayColor()
    }

    @IBAction func fortyPrepaidPressed(sender: UIButton){
        clearColors()
        othersPrepaidAmount.text = "$40.00"
        sender.backgroundColor = UIColor.lightGrayColor()
    
    }
    
    @IBAction func beginFueling(sender: AnyObject) {
        
        // segue to wait screen
        performSegue(Constants.Segues.choosePaymentPage)
        
        
    }
    
    func clearColors(){
        //openTabPressed.backgroundColor = UIColor.clearColor()
        twentyPressed.backgroundColor = UIColor.clearColor()
        tenPressed.backgroundColor = UIColor.clearColor()
        thirtyPressed.backgroundColor = UIColor.clearColor()
        fortyPressed.backgroundColor = UIColor.clearColor()
        openTabPressed.backgroundColor = UIColor.darkGrayColor()
    }
    
    
}
