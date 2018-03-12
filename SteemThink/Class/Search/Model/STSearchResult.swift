//
//  STSearchResult.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/3/8.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

@objcMembers
class STSeachPages: STBaseModel {
    var current : Int32 = 0
    var has_next : Bool = false
    var has_previous : Int32 = 0
}

@objcMembers
class STSearchResult: STBaseModel {
    var permlink : String = ""
    var created : String = ""
    var title : String = ""
    var children : Int32 = 0
    var net_votes : Int32 = 0
    var tags : Array<String>?
    var author : String = ""
    var type : String = ""
    var summary : String = ""
}
