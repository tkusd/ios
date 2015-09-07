//
//  ProjectResponse.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/11.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import Foundation
import ObjectMapper

class ProjectResponse: APIResponse {
    var id: String?
    var userID: String?
    var title: String?
    var description: String?
    var isPrivate: Bool?
    var mainScreen: String?
    var theme: String?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    
    override class func newInstance() -> Mappable {
        return ProjectResponse()
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        id <- map["id"]
        userID <- map["user_id"]
        title <- map["title"]
        description <- map["description"]
        isPrivate <- map["is_private"]
        mainScreen <- map["main_screen"]
        theme <- map["theme"]
        createdAt <- (map["created_at"], ISO8601DateTransform())
        updatedAt <- (map["updated_at"], ISO8601DateTransform())
    }
}