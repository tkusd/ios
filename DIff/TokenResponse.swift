//
//  Token.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/10.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import Foundation
import ObjectMapper

class TokenResponse: APIResponse {
    var id: String?
    var userID: String?
    var secret: String?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    
    override class func newInstance() -> Mappable {
        return TokenResponse()
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        id <- map["id"]
        userID <- map["user_id"]
        secret <- map["secret"]
        createdAt <- (map["created_at"], ISO8601DateTransform())
        updatedAt <- (map["updated_at"], ISO8601DateTransform())
    }
}
