//
//  LoginButton.swift
//  
//
//  Created by SkyArrow on 2015/9/8.
//
//

import UIKit

class LoginButton: UIButton {
    override func drawRect(rect: CGRect) {
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        self.contentEdgeInsets = UIEdgeInsetsMake(8, 16, 8, 16)

        // Normal state
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.setBackgroundColor(UIColor(red: 0/255, green: 188/255, blue: 212/255, alpha: 1), forState: UIControlState.Normal)
        
        // Highlighted state
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        self.setBackgroundColor(UIColor(red: 0/255, green: 169/255, blue: 191/255, alpha: 1), forState: UIControlState.Highlighted)
    }
}
