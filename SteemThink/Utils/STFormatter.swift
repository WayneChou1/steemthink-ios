//
//  STFormatter.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/3/5.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit
import SwiftDate

class STFormatter: NSObject {
    //MARK: - 通过parentAuthor parentPermlink 获取Permlink
    class func commentPermlink(parentAuthor:String,parentPermlink:String) -> String? {
        let myFormatter = DateFormatter()
        //也可以使用自定义的格式
        myFormatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ss.sss'Z'"
        let timeTags = "[^a-zA-Z0-9]"
        let permlinkTags = "/(-\\d{8}t\\d{9}z)/g"
        let r = self.stringReplace(pattern: timeTags, string: myFormatter.string(from: Date()))?.lowercased()
        let e = self.stringReplace(pattern: permlinkTags, string: parentPermlink)
        
        if e != nil && r != nil {
            return String.init(format: "re-%@-%@-%@", parentAuthor,e!,r!)
        }
        
        return nil
    }
    
    class func stringReplace(pattern:String,string:String) -> String? {
        var tagValue:String?
        do {
            let regex = try NSRegularExpression.init(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            // 执行替换的过程
            tagValue = regex.stringByReplacingMatches(in: string, options:  NSRegularExpression.MatchingOptions.reportProgress, range: NSRange.init(location: 0, length: string.count), withTemplate: "")
        } catch {}
        return tagValue
    }
}
