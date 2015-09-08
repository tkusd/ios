//
//  ProfileEditTableViewController.swift
//  
//
//  Created by SkyArrow on 2015/9/8.
//
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import RealmSwift
import XLForm

class ProfileEditTableViewController: XLFormViewController {
    let name = "name"
    let email = "email"
    let oldPassword = "old_password"
    let password = "password"
    
    let realm = Realm()
    var user: UserResponse?
    var delegate: ProfileEditDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "submit:")
        initForm()
    }
    
    private func initForm(){
        let form = XLFormDescriptor(title: "Edit profile")
        var section: XLFormSectionDescriptor
        var row: XLFormRowDescriptor
        
        // Profile section
        section = XLFormSectionDescriptor()
        form.addFormSection(section)
        
        // Name
        row = XLFormRowDescriptor(tag: name, rowType: XLFormRowDescriptorTypeName, title: "Name")
        row.required = true
        row.value = user?.name
        section.addFormRow(row)
        
        // Email
        row = XLFormRowDescriptor(tag: email, rowType: XLFormRowDescriptorTypeEmail, title: "Email")
        row.required = true
        row.value = user?.email
        section.addFormRow(row)
        
        // Password section
        section = XLFormSectionDescriptor()
        form.addFormSection(section)
        
        // Current password
        row = XLFormRowDescriptor(tag: oldPassword, rowType: XLFormRowDescriptorTypePassword, title: "Current password")
        section.addFormRow(row)
        
        // New password
        row = XLFormRowDescriptor(tag: password, rowType: XLFormRowDescriptorTypePassword, title: "New password")
        section.addFormRow(row)
        
        // Delete section
        section = XLFormSectionDescriptor()
        form.addFormSection(section)
        
        // Delete account
        row = XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeButton, title: "Delete account")
        row.action.formBlock = {(sender: XLFormRowDescriptor) -> Void in
            self.showDeleteAccountDialog()
            self.deselectFormRow(sender)
        }
        section.addFormRow(row)
        
        self.form = form
    }
    
    func submit(_: UIBarButtonItem!){
        let errors = self.formValidationErrors()
        
        if errors.count > 0 {
            return
        }

        var values = self.httpParameters()
        let token = realm.objects(Token).first!
        let nilKeys = values.keys.array.filter { values[$0] is NSNull }
        
        for key in nilKeys {
            values.removeValueForKey(key)
        }
        
        Alamofire.request(.PUT, Constant.USERS_URL + "/" + token.userID, parameters: values as? [String: AnyObject], headers: [
            "Authorization": "Bearer " + token.id
            ])
            .validate(statusCode: 200..<300)
            .responseObject {(res: UserResponse?, err: NSError?) in
                if err != nil {
                    println(err)
                    return
                }

                self.delegate?.userUpdateSuccess(res)
                self.navigationController?.popViewControllerAnimated(true)
        }

    }
    
    func showDeleteAccountDialog(){
        let alert = UIAlertController(title: "Delete account", message: "Are you sure?", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: { (action: UIAlertAction!) in
            self.deleteUser()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func deleteUser(){
        //
    }
}

protocol ProfileEditDelegate {
    func userUpdateSuccess(UserResponse?)
}