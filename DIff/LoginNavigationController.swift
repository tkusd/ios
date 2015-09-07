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
    
    func createToken(email: String, password: String) {
        Alamofire.request(.POST, Constant.TOKEN_URL, parameters: [
            "email": email,
            "password": password
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
                delegate.showLoginScreen(false)
        }
    }
}
