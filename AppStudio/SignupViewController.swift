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
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    
    @IBAction func validate(sender: UIButton) {
//        if self.txtName.validateName(){
//           if self.txtEmail.validateEmail() {
//              if self.txtPassword.validatePassword() {
//                    self.alert("login success")
//                }
//                else{
//                    self.alert("invalid password")}
//            }
//            else {
//                self.alert("invalid email")
//            }
//        }
//        else {
//            self.alert("column have to type")
//        }
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
