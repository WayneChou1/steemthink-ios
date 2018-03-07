//
//  STUser.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/27.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

@objcMembers
class STUserEscrow: STBaseModel {
    var terms:String = ""
}

@objcMembers
class STUserProfile: STBaseModel {
    var cover_image:String = ""
    var profile_image:String = ""
    var about:String = ""
    var website:String = ""
}

@objcMembers
class STUserMetaData: STBaseModel {
    var profile : Dictionary<String, Any>?
    var escrow : Dictionary<String, Any>?
    var user_profile :STUserProfile?
    var user_escrow : STUserEscrow?
    override init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        //json_meta
//        self.json_meta = STUserMetaData.init(dict: NSDictionary_STExtension.getDictionaryFromJSONString(jsonString: self.json_metadata) as! [String : Any])
        if let profile = self.profile{
            self.user_profile = STUserProfile.init(dict: profile)
        }
        if let user_escrow = self.escrow {
            self.user_escrow = STUserEscrow.init(dict: user_escrow)
        }

    }
}

@objcMembers
class STUser: STBaseModel {
    var id: Int32 = 0
    
    var name:String = ""
    var json_metadata:String = ""
    var json_meta:STUserMetaData?
    
    override init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        //json_meta
        self.json_meta = STUserMetaData.init(dict: NSDictionary_STExtension.getDictionaryFromJSONString(jsonString: self.json_metadata) as! [String : Any])
    }
}
