//
//  ProfileEditViewController.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/11.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import RealmSwift

protocol ProfileEditViewDelegate {
    func userUpdateResponse(UserResponse?)
}

class ProfileEditViewController: UIViewController {
    let realm = Realm()
    var user: UserResponse?
    var delegate: ProfileEditViewDelegate?
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the value of text fields
        txtName.text = user?.name
        txtEmail.text = user?.email
        
        // Add the right button on the navigation bar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "updateUser:")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func updateUser(sender: UIButton) {
        let token = realm.objects(Token).first!
        var data = [
            "name": txtName.text,
            "email": txtEmail.text
        ]
        
        if !txtOldPassword.text.isEmpty && !txtNewPassword.text.isEmpty {
            data["old_password"] = txtOldPassword.text
            data["password"] = txtNewPassword.text
        }
        
        Alamofire.request(.PUT, Constant.USERS_URL + "/" + token.userID, parameters: data, headers: [
            "Authorization": "Bearer " + token.id
            ])
            .validate(statusCode: 200..<300)
            .responseObject {(res: UserResponse?, err: NSError?) in
                if err != nil {
                    println(err)
                    return
                }
                
                if self.delegate != nil {
                    self.delegate?.userUpdateResponse(res)
                }
                
                self.navigationController?.popViewControllerAnimated(true)
        }
    }
}
