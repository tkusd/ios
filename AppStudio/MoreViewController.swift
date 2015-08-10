//
//  MoreViewController.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/10.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class MoreViewController: UIViewController {
    let realm = Realm()
    
    @IBAction func btnLogoutPressed(sender: UIButton) {
        let token = realm.objects(Token).first
        let url = Constant.TOKEN_URL + token!.id
        
        Alamofire.request(.DELETE, url)
            .validate(statusCode: 200..<300)
            .response {_, _, _, err in
                if err != nil {
                    println(err)
                    return
                }
                
                // Delete all objects in Realm
                self.realm.write {
                    self.realm.deleteAll()
                }
                
                // Go to the login page
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let window = delegate.window!
                
                UIView.transitionWithView(window, duration: 0.33, options: .CurveEaseOut, animations: {
                    let oldState = UIView.areAnimationsEnabled()
                    let controller = self.storyboard?.instantiateViewControllerWithIdentifier("login") as! LoginViewController
                    
                    UIView.setAnimationsEnabled(false)
                    window.rootViewController = controller
                    UIView.setAnimationsEnabled(oldState)
                    }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
