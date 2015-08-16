//
//  LoginViewController.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/10.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import UIKit

extension UITextField {
    var notEmpty: Bool{
        get {
            return self.text != ""
        }
    }
    func validate(RegEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", RegEx)
        return predicate.evaluateWithObject(self.text)
    }
    func validateName()->Bool{
        return self.validate("[A-Z0-9a-z._%+-],{3,10}")
    }
    func validateEmail() -> Bool {
        return self.validate("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}")
    }
    func validatePassword() -> Bool {
        return self.validate("^[A-Z0-9a-z]{6,18}")
    }
}



class LoginViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func validate(sender: UIButton) {
        
        if self.txtEmail.validateEmail() {
            if self.txtPassword.validatePassword() {
                self.alert("login success")
            } else {
                self.alert("invalid password")
            }
        }
        else {
            self.alert("invalid email")
        }
        
    }

    @IBAction func btnLoginPressed(sender: UIButton) {
        let navController = self.navigationController as! LoginNavigationController
        navController.createToken(txtEmail.text, password: txtPassword.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func alert(message: String) {
        let alc = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alc.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alc, animated: true, completion: nil)
    }
    
}
