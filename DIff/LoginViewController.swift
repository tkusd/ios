//
//  LoginViewController.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/10.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import UIKit
import SwiftValidator

class LoginViewController: UIViewController, ValidationDelegate, UITextFieldDelegate, LoginRequestDelegate {
    let validator = Validator()
    
    @IBOutlet weak var email: LoginTextField!
    @IBOutlet weak var password: LoginTextField!
    
    @IBAction func inputChanged(sender: LoginTextField) {
        sender.error = nil
        validator.validate(self)
    }
    
    @IBAction func loginPressed(sender: LoginButton) {
        login()
    }
    
    override func viewDidLoad() {
        var tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        email.delegate = self
        password.delegate = self
        
        validator.registerField(email, rules: [RequiredRule(), EmailRule()])
        validator.registerField(password, rules: [RequiredRule()])
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == email {
            email.resignFirstResponder()
            password.becomeFirstResponder()
        } else if textField == password {
            password.resignFirstResponder()
            login()
        }
        
        return true
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func login(){
        validator.validate(self)
        
        if validator.errors.count > 0 {
            return
        }
        
        let navController = self.navigationController as! LoginNavigationController
        navController.createToken(email.text, password: password.text, delegate: self)
    }
    
    func validationSuccessful() {
        //
    }
    
    func validationFailed(errors: [UITextField : ValidationError]) {
        for (field_, error) in errors {
            let field = field_ as! LoginTextField
            field.error = error.errorMessage
        }
    }
    
    func loginSuccess(res: TokenResponse?) {
        //
    }
    
    func loginError(res: TokenResponse?, err: NSError?) {
        if let field = res?.field {
            switch field {
            case "email":
                email.error = res?.message
                
            case "password":
                password.error = res?.message
                
            default:
                println(err)
            }
        }
    }
}
