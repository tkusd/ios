//
//  Constant.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/10.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import Foundation

struct Constant {
    static let API_URL = "http://tkusd.zespia.tw/v1/"
    static let TOKEN_URL = API_URL + "tokens/"
    static let USER_URL = API_URL + "users/"
    static let USER_PROJECT_URL = USER_URL + "%@/projects/"
    static let PROJECT_URL = API_URL + "projects/"
    
    static let DEFAULTS_TOKEN = "token"
    static let DEFAULTS_USER_ID = "user_id"
}