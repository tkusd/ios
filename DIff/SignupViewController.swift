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
import SwiftValidator

class SignupViewController: UIViewController, UITextFieldDelegate, ValidationDelegate {
    let validator = Validator()
    
    @IBOutlet weak var name: LoginTextField!
    @IBOutlet weak var email: LoginTextField!
    @IBOutlet weak var password: LoginTextField!
    
    @IBAction func signupPressed(sender: AnyObject) {
        signup()
    }
    
    @IBAction func inputChanged(sender: LoginTextField) {
        sender.error = nil
        validator.validate(self)
    }
    
    override func viewDidLoad() {
        var tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        name.delegate = self
        email.delegate = self
        password.delegate = self
        
        validator.registerField(name, rules: [RequiredRule(), MaxLengthRule(length: 100)])
        validator.registerField(email, rules: [RequiredRule(), EmailRule()])
        validator.registerField(password, rules: [RequiredRule(), MinLengthRule(length: 6), MaxLengthRule(length: 50)])
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == name {
            name.resignFirstResponder()
            email.becomeFirstResponder()
        } else if textField == email {
            email.resignFirstResponder()
            password.becomeFirstResponder()
        } else if textField == password {
            password.resignFirstResponder()
            signup()
        }
        
        return true
    }
    
    func signup(){
        validator.validate(self)
        
        if validator.errors.count > 0 {
            return
        }
        
        Alamofire.request(.POST, Constant.USERS_URL, parameters: [
            "name": name.text,
            "email": email.text,
            "password": password.text
            ])
            .validate(statusCode: 200..<300)
            .responseObject {(res: UserResponse?, err: NSError?) in
                if err != nil {
                    self.handleRequestError(res, err: err)
                    return
                }
                
                let navController = self.navigationController as! LoginNavigationController
                navController.createToken(self.email.text, password: self.password.text)
        }
    }
    
    func handleRequestError(res: UserResponse?, err: NSError?){
        if let field = res?.field {
            switch field {
            case "name":
                name.error = res?.message
            
            case "email":
                email.error = res?.message
                
            case "password":
                password.error = res?.message
                
            default:
                println(err)
            }
        }
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
}
