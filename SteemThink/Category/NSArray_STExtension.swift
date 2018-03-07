//
//  NSArray_STExtension.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/27.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class NSArray_STExtension: NSObject {

}

extension NSArray_STExtension{
    class func getJSONStringFromArray(array:[AnyObject]) -> String {
        if (!JSONSerialization.isValidJSONObject(array)) {
            print("Can not prase JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: array, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
}
