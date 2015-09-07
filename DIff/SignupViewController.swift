//
//  SignupViewController.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/11.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class SignupViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func btnSignupPressed(sender: UIButton) {
        let name = txtName.text
        let email = txtEmail.text
        let password = txtPassword.text

        Alamofire.request(.POST, Constant.USER_URL, parameters: [
            "name": name,
            "email": email,
            "password": password
        ])
            .validate(statusCode: 200..<300)
            .responseObject {(res: UserResponse?, err: NSError?) in
                if err != nil {
                    println(err)
                    return
                }
                
                let navController = self.navigationController as! LoginNavigationController
                navController.createToken(email, password: password)
            }
    }
    
    @IBAction func btnLoginPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
