//
//  ProjectListResponse.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/11.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import Foundation
import ObjectMapper

class ProjectListResponse: APIResponse {
    var data: [ProjectResponse]?
    var hasMore: Bool?
    var count: Int?
    var limit: Int?
    var offset: Int?
    
    override class func newInstance() -> Mappable {
        return ProjectListResponse()
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        data <- map["data"]
        hasMore <- map["has_more"]
        count <- map["count"]
        limit <- map["limit"]
        offset <- map["offset"]
    }
}