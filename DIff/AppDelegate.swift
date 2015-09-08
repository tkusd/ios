//
//  AppDelegate.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/10.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let realm = Realm()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let token = realm.objects(Token)
        
        self.showLoginScreen(token.count == 0, animated: false)
        application.setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        
        return true
    }
    
    func showLoginScreen(active: Bool, animated: Bool = true){
        var controller: UIViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if (active){
            controller = storyboard.instantiateViewControllerWithIdentifier("loginNav") as! LoginNavigationController
        } else {
            controller = storyboard.instantiateInitialViewController() as! UINavigationController
        }
        
        self.window!.makeKeyAndVisible()
        
        if (animated) {
            UIView.transitionWithView(self.window!, duration: 0.33, options: .CurveEaseOut | .TransitionCrossDissolve, animations: {
                let oldState = UIView.areAnimationsEnabled()
                
                UIView.setAnimationsEnabled(false)
                self.window!.rootViewController = controller
                UIView.setAnimationsEnabled(oldState)
                }, completion: nil)
        } else {
            self.window!.rootViewController = controller
        }
    }
}

