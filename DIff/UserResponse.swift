//
//  UserResponse.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/11.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import Foundation
import ObjectMapper

class UserResponse: APIResponse {
    var id: String?
    var name: String?
    var email: String?
    var avatar: String?
    var language: String?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    
    override class func newInstance() -> Mappable {
        return UserResponse()
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        avatar <- map["avatar"]
        language <- map["language"]
        createdAt <- (map["created_at"], ISO8601DateTransform())
        updatedAt <- (map["updated_at"], ISO8601DateTransform())
    }
}
