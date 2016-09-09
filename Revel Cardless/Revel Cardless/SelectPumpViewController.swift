//
//  SelectPumpViewController.swift
//  test
//
//  Created by Sanjay Shrestha on 9/8/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import UIKit

class SelectPumpViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var testPump = [Pump]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(testPump.count)
        
        
        
        dispatch_async(dispatch_get_main_queue(),{
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            self.testPump = appDelegate.pumpList
            print("dispatch")
            
        })
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        //let getJSON = JSONpumpParser()
        //getJSON.runJSONparser()
        //testPump = JSONpumpParser.pumpArray

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
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testPump.count
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegue(Constants.Segues.chooseFuel)
    }
 
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pumpCell", forIndexPath: indexPath) as! PumpCollectionViewCell
        //print(testPump[0].pump_name)
        let pump = testPump[indexPath.row] as Pump
        
        
        cell.pumpText.text = pump.pump_name
        print(pump.pump_name)
        print("cell")
        
        if (pump.pump_is_occupied == true){
            cell.pumpText.backgroundColor = UIColor.redColor()
            
        }
        print(pump.pump_is_occupied)
        
        return cell
    }

   

}
