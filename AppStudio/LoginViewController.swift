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
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!

    @IBAction func validateEmail(sender: AnyObject, forEvent event: UIEvent) {
        if !validateEmail(txtEmail.text){
            lblEmail.text="invalid email"
            return
        }
    }
    
    @IBAction func validateEmailfinished(sender: AnyObject, forEvent event: UIEvent) {
    }
    
   
    @IBAction func validatePassword(sender: AnyObject, forEvent event: UIEvent) {
        if !validatePassword(){
            lblPassword.text="length must be 6 to 50"
            return
        }
    }
    
    @IBAction func validatePasswordfinished(sender: AnyObject, forEvent event: UIEvent) {
       lblPassword.text=""
    }
   
    @IBAction func btnLoginPressed(sender: UIButton) {
        let navController = self.navigationController as! LoginNavigationController
        navController.createToken(txtEmail.text, password: txtPassword.text)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblEmail.text="email is required"
        lblPassword.text="password is required"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate)
    }
    
    func validatePassword()->Bool{
        var Result=false
        var passwordLength:Int?
        passwordLength=count(txtPassword.text!)
        if passwordLength > 6 && passwordLength<50 {
           Result=true
        }
        return Result
    }
    
    func alert(message: String) {
        let alc = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alc.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alc, animated: true, completion: nil)
    }
    
}
