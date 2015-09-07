//
//  APIResponse.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/11.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import Foundation
import ObjectMapper

class APIResponse: Mappable {
    var code: Int?
    var message: String?
    var field: String?
    
    class func newInstance() -> Mappable {
        return APIResponse()
    }
    
    func mapping(map: Map) {
        code <- map["error"]
        message <- map["message"]
        field <- map["field"]
    }
}