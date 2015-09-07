//
//  ProjectPreviewViewController.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/11.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import UIKit

class ProjectPreviewViewController: UIViewController {
    var projectID: String?

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the web view
        let url = NSURL(string: String(format: Constant.PROJECT_PREVIEW_URL, projectID!))
        let req = NSURLRequest(URL: url!)
        
        webView.loadRequest(req)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
