//
//  LoginViewController.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/10.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func btnLoginPressed(sender: UIButton) {
        Alamofire.request(.POST, Constant.TOKEN_URL, parameters: [
            "email": txtEmail.text,
            "password": txtPassword.text
        ])
        .validate(statusCode: 200..<300)
        .responseJSON {_,  _, json, err in
            println(json)
            
            if err != nil {
                return
            }
            
            self.defaults.setObject(json, forKey: Constant.DEFAULTS_TOKEN)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
