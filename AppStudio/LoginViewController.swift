//
//  LoginViewController.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/10.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import RealmSwift

class LoginViewController: UIViewController {
    let realm = Realm()
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func btnLoginPressed(sender: UIButton) {
        Alamofire.request(.POST, Constant.TOKEN_URL, parameters: [
            "email": txtEmail.text,
            "password": txtPassword.text
        ])
            .validate(statusCode: 200..<300)
            .responseObject { (res: TokenResponse?, err: NSError?) in
                if err != nil {
                    println(err)
                    return
                }
                
                // Save the token to Realm
                let token = Token()
                token.id = res!.id!
                token.userID = res!.userID!
                token.createdAt = res!.createdAt!
                token.updatedAt = res!.updatedAt!
                
                self.realm.write {
                    self.realm.add(token)
                }
                
                // Go to the project list view
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let window = delegate.window!
                
                UIView.transitionWithView(window, duration: 0.33, options: .CurveEaseOut, animations: {
                    let oldState = UIView.areAnimationsEnabled()
                    let controller = self.storyboard?.instantiateInitialViewController() as! UINavigationController
                    
                    UIView.setAnimationsEnabled(false)
                    window.rootViewController = controller
                    UIView.setAnimationsEnabled(oldState)
                    }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
