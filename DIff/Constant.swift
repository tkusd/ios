//
//  Constant.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/10.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import Foundation

struct Constant {
    static let BASE_URL = "http://tkusd.zespia.tw/"
    static let API_URL = BASE_URL + "v1/"
    static let TOKENS_URL = API_URL + "tokens"
    static let USERS_URL = API_URL + "users"
    static let USER_PROJECT_URL = USERS_URL + "/%@/projects"
    static let PROJECT_URL = API_URL + "/projects"
    static let PROJECT_PREVIEW_URL = BASE_URL + "projects/%@/embed"
    
    static let DEFAULTS_TOKEN = "token"
    static let DEFAULTS_USER_ID = "user_id"
}