//
//  SettingsTableViewController.swift
//  
//
//  Created by SkyArrow on 2015/9/8.
//
//

import UIKit
import Alamofire
import RealmSwift
import AlamofireObjectMapper
import Kingfisher

class SettingsTableViewController: UITableViewController, ProfileEditDelegate {
    let realm = Realm()
    var user: UserResponse?
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
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
    
    func updateUserView(){
        userName.text = user!.name
        avatar.kf_setImageWithURL(NSURL(string: user!.avatar!)!)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 && indexPath.row == 1 {
            showLogoutDialog()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ProfileEditSegue" {
            var controller = segue.destinationViewController as! ProfileEditTableViewController
            controller.user = user
            controller.delegate = self
            controller.hidesBottomBarWhenPushed = true
        }
    }
    
    func userUpdateSuccess(user: UserResponse?) {
        self.user = user
        updateUserView()
    }
    
    func showLogoutDialog(){
        let alert = UIAlertController(title: "Log out", message: "Are you sure?", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Log out", style: .Default, handler: { (action: UIAlertAction!) in
            self.logout()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func logout(){
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
}
