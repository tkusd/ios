//
//  LoginNavigationController.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/11.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import AlamofireObjectMapper

class LoginNavigationController: UINavigationController {
    let realm = Realm()
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createToken(email: String, password: String) {
        progressBar("loading", true)
        Alamofire.request(.POST, Constant.TOKEN_URL, parameters: [
            "email": email,
            "password": password
            ])
            .validate(statusCode: 200..<300)
            .responseObject { (res: TokenResponse?, err: NSError?) in
                if err != nil {
                    self.hideProgressBar()
                    var code:Int?
                    code=res?.code
                    println(code)
                    
                    if(code==1104){
                        self.alert("invalid email")
                    }
                    if(code==1100){
                        self.alert("invalid email or invalid password")
                    }
                    if(code==1105){
                        self.alert("invalid email or invalid password")
                    }
                    if(code==1300){
                        self.alert("invalid password")
                    }
                    if(code==1200){
                        self.alert("email hasn't been used")
                    }
                    println(err)
                    return
                }
                
                // Save the token to Realm
                let token = Token()
                token.id = res!.id!
                token.userID = res!.userID!
                token.createdAt = res!.createdAt!
                token.updatedAt = res!.updatedAt!
//                println(res)
                
                self.realm.write {
                    self.realm.add(token)
                }
                
                // Go to the project list view
                self.hideProgressBar()
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                delegate.showLoginScreen(false)
        }
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
