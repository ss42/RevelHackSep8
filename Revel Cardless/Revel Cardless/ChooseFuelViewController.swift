//
//  ChooseFuelViewController.swift
//  test
//
//  Created by Sanjay Shrestha on 9/8/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import UIKit

class ChooseFuelViewController: UIViewController {
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
    
    
    //When you don't know how much you need
    @IBAction func openTabPressed(sender: AnyObject) {
        
        
    }

    @IBAction func twentyPrepaidPressed(sender: AnyObject) {
        
        
        
    }

    @IBAction func fortyPrepaidPressed(sender: AnyObject){
    
    
    }
    
    @IBAction func beginFueling(sender: AnyObject) {
        
        
        
    }
    
    
    
}
