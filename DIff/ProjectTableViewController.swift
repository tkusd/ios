//
//  ProjectTableViewController.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/10.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import AlamofireObjectMapper

class ProjectTableViewController: UITableViewController {
    var projectList: [ProjectResponse] = []
    let realm = Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the project list
        let token = realm.objects(Token)
        let url = String(format: Constant.USER_PROJECT_URL, token.first!.userID)
        
        Alamofire.request(.GET, url, headers: [
            "Authorization": "Bearer " + token.first!.id
            ])
            .validate(statusCode: 200..<300)
            .responseObject { ( res: ProjectListResponse?, err: NSError?) in
                if err != nil {
                    println(err)
                    return
                }
                
                self.projectList += res!.data!
                self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = projectList[indexPath.row].title
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ProjectPreviewSegue" {
            let viewController = segue.destinationViewController as! ProjectPreviewViewController
            let row = tableView.indexPathForSelectedRow()?.row
            viewController.projectID = projectList[row!].id
            viewController.hidesBottomBarWhenPushed = true
        }
    }
}
