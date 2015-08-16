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
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createToken(email: String, password: String) {
        Alamofire.request(.POST, Constant.TOKEN_URL, parameters: [
            "email": email,
            "password": password
            ])
            .validate(statusCode: 200..<300)
            .responseObject { (res: TokenResponse?, err: NSError?) in
                if err != nil {
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
                self.showActivityIndicator(self.loadingView)
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
                self.hideActivityIndicator(self.loadingView)
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                delegate.showLoginScreen(false)
        }
    }
    
    func alert(message: String) {
        let alc = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alc.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alc, animated: true, completion: nil)
    }

    /*
    Show customized activity indicator,
    actually add activity indicator to passing view
    
    @param uiView - add activity indicator to this view
    */
    func showActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColorFromHex(0xffffff, alpha: 0.3)
        
        loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.center = CGPointMake(loadingView.frame.size.width / 2, loadingView.frame.size.height / 2);
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    /*
    Hide activity indicator
    Actually remove activity indicator from its super view
    
    @param uiView - remove activity indicator from this view
    */
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    /*
    Define UIColor from hex value
    
    @param rgbValue - hex color value
    @param alpha - transparency level
    */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    
}
