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
    
    
    var passwordLength:Int?
       @IBAction func validate(sender: AnyObject) {
        if validateEmail()==false {
            
            self.alert("invalid email")
            return
        }
        if validatePassword()==false{
            self.alert("length less than 6")
            return
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

    func validateEmail() -> Bool {
        var Result=false
        var Rule="[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        if txtEmail.text != Rule {
            Result=true
        }
        return Result
    }
    func validatePassword()->Bool{
        var Result=false
        passwordLength=count(txtPassword.text.utf16)
        if passwordLength > 6 {
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
