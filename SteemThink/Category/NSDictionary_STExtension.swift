//
//  NSDictionary_STExtension.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/24.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class NSDictionary_STExtension{

}

extension NSDictionary_STExtension{
    /**
     字典转换为JSONString
     
     - parameter dictionary: 字典参数
     
     - returns: JSONString
     */
    class func getJSONStringFromDictionary(dictionary:Dictionary<String, Any>) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("Can not prase JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
    /// JSONString转换为字典
    class func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
}
