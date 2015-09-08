//
//  SettingsViewController.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/11.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import AlamofireObjectMapper
import Kingfisher

class SettingsViewController: UIViewController, ProfileEditViewDelegate {
    let realm = Realm()
    var user: UserResponse?
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBAction func btnLogoutPressed(sender: UIButton) {
        let token = realm.objects(Token).first!
        let url = Constant.TOKENS_URL + "/" + token.id
        
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
                
                delegate.showLoginScreen(true)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = realm.objects(Token).first!
        let url = Constant.USERS_URL + "/" + token.userID
        
        Alamofire.request(.GET, url, headers: [
            "Authorization": "Bearer " + token.id
            ])
            .validate(statusCode: 200..<300)
            .responseObject {(res: UserResponse?, err: NSError?) in
                if err != nil {
                    println(err)
                    return
                }
                
                self.user = res
                self.updateUserView()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.topItem!.title = self.title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ProfileEditSegue" {
            var controller = segue.destinationViewController as! ProfileEditViewController
            controller.user = user
            controller.delegate = self
        }
    }
    
    func updateUserView() {
        nameLabel.text = user!.name
        avatarImage.kf_setImageWithURL(NSURL(string: user!.avatar!)!)
    }
    
    func userUpdateResponse(res: UserResponse?) {
        self.user = res
        self.updateUserView()
    }
}
