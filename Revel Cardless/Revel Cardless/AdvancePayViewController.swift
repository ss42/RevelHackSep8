//
//  AdvancePayViewController.swift
//  Revel Cardless
//
//  Created by Sanjay Shrestha on 9/9/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import UIKit

class AdvancePayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let testArray = ["Club Sandwich", "BLT", "Buffalo Chicken Sandwich", "CheeseBurger", "Sprite","Coke", "Fanta"]
    let testPrice = ["$7.00", "$5.00", "$7.00", "$10.99", "$0.99", "$0.99", "$0.99"]
    @IBOutlet weak var tableView: UITableView!
    
    var promotionItems = [Promotion_product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       tableView.reloadData()
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
    
    
    @IBAction func choosePayment(sender: AnyObject) {
        performSegue(Constants.Segues.advancePaymentPage)
        
    }
    
    
    
    @IBAction func backPressed(sender: AnyObject) {
        performSegue(Constants.Segues.menuPage)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegue(Constants.Segues.advancePaymentPage)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ItemsCell")!
        
        //let promotion = promotionItems[indexPath.row]
        cell.textLabel!.text = testArray[indexPath.row]//promotion.product_name
        cell.detailTextLabel?.text = testPrice[indexPath.row]//String(promotion.product_price)
        

        return cell
    }
    
    

}
