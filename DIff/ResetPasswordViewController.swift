//
//  ResetPasswordViewController.swift
//  
//
//  Created by SkyArrow on 2015/9/9.
//
//

import UIKit
import SwiftValidator
import Alamofire

class ResetPasswordViewController: UIViewController, ValidationDelegate, UITextFieldDelegate {
    let validator = Validator()
    
    @IBOutlet weak var email: LoginTextField!
    
    @IBAction func btnPressed(sender: LoginButton) {
        resetPassword()
    }
    
    @IBAction func inputChanged(sender: LoginTextField) {
        sender.error = nil
        validator.validate(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        email.delegate = self
        
        validator.registerField(email, rules: [RequiredRule(), EmailRule()])
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == email {
            email.resignFirstResponder()
            resetPassword()
        }
        
        return true
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func resetPassword(){
        validator.validate(self)
        
        if validator.errors.count > 0 {
            return
        }
        
        Alamofire.request(.POST, Constant.API_URL + "passwords/reset", parameters: [
            "email": email.text]
        )
            .validate(statusCode: 200..<300)
            .response {_, _, _, err in
                if err != nil {
                    println(err)
                    return
                }
                
                self.navigationController?.popViewControllerAnimated(true)
                
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
