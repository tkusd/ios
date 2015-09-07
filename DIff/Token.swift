//
//  Token.swift
//  AppStudio
//
//  Created by SkyArrow on 2015/8/11.
//  Copyright (c) 2015年 tkusd. All rights reserved.
//

import Foundation
import RealmSwift

class Token: Object {
    dynamic var id = ""
    dynamic var userID = ""
    dynamic var createdAt = NSDate(timeIntervalSince1970: 1)
    dynamic var updatedAt = NSDate(timeIntervalSince1970: 1)
}