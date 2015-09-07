//
//  LoginViewController.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/10.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
   
    @IBAction func btnLoginPressed(sender: UIButton) {
        let navController = self.navigationController as! LoginNavigationController
        navController.createToken(txtEmail.text, password: txtPassword.text)
    }
}
