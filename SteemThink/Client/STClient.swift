//
//  SteemClient.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/22.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

let baseURL:String = "https://v2.steemconnect.com"
let appId:String = ""

//GET /get_discussions_by_trending
let discussions_by_trending = "https://api.steemjs.com/get_discussions_by_trending?"

//GET /get_discussions_by_created
let discussions_by_created = "https://api.steemjs.com/get_discussions_by_created?"

//GET /get_discussions_by_hot
let discussions_by_hot = "https://api.steemjs.com/get_discussions_by_hot?"

//GET /get_accounts
let get_accounts = "https://api.steemjs.com/get_accounts?"



class STClient: NSObject {
    
    typealias STClientCallBack = (_ response: Any?,_ error: Error?)->()
    
    func post(url:String,body:Dictionary<String, Any>?,cb:String?) -> Void {
        let client = STAFNetworkTools.sharedTools;
//        设置请求的编码类型
        client.requestSerializer.setValue("", forHTTPHeaderField: "")
//        var url:String = baseURL
//        var r = (new Date).toISOString().replace(/[^a-zA-Z0-9]+/g, "").toLowerCase();
//        return e = e.replace(/(-\d{8}t\d{9}z)/g, ""), "re-" + t + "-" + e + "-" + r
    }
    
    class func get(url:String!,parameters:AnyObject?,to:UIView?,finished:@escaping STClientCallBack){
        STAFNetworkTools.sharedTools.request(method: .GET, urlString: url, parameters: parameters) { (response: Any?,error: Error?) in
            finished(response,error)
        }
    }
}
