//
//  CustumView.swift
//  Revel Cardless
//
//  Created by Sanjay Shrestha on 9/9/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import UIKit



extension UIView {
    
    
    @IBInspectable
    var borderWidth: CGFloat{
        get {
            return layer.borderWidth
        }
        set(newBoarderWidth){
            layer.borderWidth = newBoarderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor?{
        get {
            return layer.borderColor != nil ? UIColor(CGColor: layer.borderColor!) : nil
        }
        set {
            layer.borderColor = newValue?.CGColor
        }
    }
    @IBInspectable
    var cornerRadius: CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue != 0
        }
    }
    
    
    
    
}
class UnderlinedLabel: UILabel {
    
    @IBInspectable var leftLine: Bool = false { didSet{ drawLines() } }
    @IBInspectable var rightLine: Bool = false { didSet{ drawLines() } }
    @IBInspectable var bottomLine: Bool = false { didSet{ drawLines() } }
    @IBInspectable var topLine: Bool = false { didSet{ drawLines() } }
    
    func drawLines(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.redColor().CGColor
        border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: width)
        border.borderWidth = width
        layer.addSublayer(border)
    }
}