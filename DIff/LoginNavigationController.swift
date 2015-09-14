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
    
    func createToken(email: String, password: String){
        createToken(email, password: password, delegate: nil)
    }
    
    func createToken(email: String, password: String, delegate: LoginRequestDelegate?) {
        Alamofire.request(.POST, Constant.TOKENS_URL, parameters: [
            "email": email,
            "password": password
            ])
            .validate(statusCode: 200..<300)
            .responseObject { (res: TokenResponse?, err: NSError?) in
                if err != nil {
                    delegate?.loginError(res, err: err)
                    return
                }
                
                // Save the token to Realm
                let token = Token()
                token.id = res!.id!
                token.userID = res!.userID!
                token.secret = res!.secret!
                token.createdAt = res!.createdAt!
                token.updatedAt = res!.updatedAt!
                
                self.realm.write {
                    self.realm.add(token)
                }
                
                delegate?.loginSuccess(res)
                
                // Go to the project list view
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.showLoginScreen(false)
        }
    }
}

protocol LoginRequestDelegate {
    func loginSuccess(res: TokenResponse?)
    func loginError(res: TokenResponse?, err: NSError?)
}