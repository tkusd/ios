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
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    
    @IBAction func validateName(sender: AnyObject, forEvent event: UIEvent) {
        if !validateName(){
           lblName.text="less than 3 to 100"
        }
    }
    @IBAction func validateNamefinished(sender: AnyObject, forEvent event: UIEvent) {
        lblName.text=""
    }
    
    @IBAction func validateEmail(sender: AnyObject, forEvent event: UIEvent) {
        if !validateEmail(txtEmail.text){
            lblEmail.text="invalid email"
            return
        }
    }
    @IBAction func validateEmailfinished(sender: AnyObject, forEvent event: UIEvent) {
        lblEmail.text=""
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
    
    @IBAction func btnSignupPressed(sender: UIButton) {
        let name = txtName.text
        let email = txtEmail.text
        let password = txtPassword.text
        progressBar("loading", true)
        Alamofire.request(.POST, Constant.USER_URL, parameters: [
            "name": name,
            "email": email,
            "password": password
        ])
            .validate(statusCode: 200..<300)
            .responseObject {(res: UserResponse?, err: NSError?) in
                if err != nil {
                    var code:Int?
                    code=res?.code
                    println(code)
                    if(code==1301){
                        self.alert("email has been used")
                    }
                    println(err)
                    return
                }
                
                let navController = self.navigationController as! LoginNavigationController
                navController.createToken(email, password: password)
                self.hideProgressBar()
        }
    }
    
    @IBAction func btnLoginPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text="name is required"
        lblEmail.text="email is required"
        lblPassword.text="password is required"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func validateName()->Bool{
       var Result=false
       var nameLength:Int?
       nameLength=count(txtName.text!)
        if nameLength>3 && nameLength<100{
           Result=true
        }
        return Result
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

    
    func progressBar(msg:String, _ indicator:Bool ) {
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.whiteColor()
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 180, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
    }
    func hideProgressBar(){
        messageFrame.hidden=true
    }

    
    func alert(message: String) {
        let alc = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alc.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alc, animated: true, completion: nil)
    }

}
