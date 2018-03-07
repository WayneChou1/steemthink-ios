//
//  AFNetworkTools.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/22.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit
import AFNetworking

/// 请求方法
///
/// - GET:  get
/// - POST: post
enum AFRequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class STAFNetworkTools: AFHTTPSessionManager {
    // 单例
    static let sharedTools: STAFNetworkTools = {
        let instance = STAFNetworkTools()
        instance.responseSerializer.acceptableContentTypes?.insert("text/html")
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return instance
    }()
    
    
    // (response: AnyObject?, error: NSError?)->()
    // 定义请求完成的回调的别名
    typealias AFNRequestCallBack = (_ response: Any?,_ error: Error?)->()
    
    /// 请求数据
    ///
    /// - parameter urlString:  请求地址
    /// - parameter parameters: 请求参数
    /// - parameter finished:   请求成功或者失败的回调
    func request(method: AFRequestMethod = .GET, urlString: String, parameters: AnyObject?, finished:@escaping AFNRequestCallBack){
        
        print("urlString ============  " + urlString)
        print("parameters ============  " + String(describing: parameters))
        
        // dataTaskWithHttp 是写在 .m 文件里面的
        // 对应在 Swift 中的，就是 private 修饰的方法
        
        // 定义请求成功的闭包
        let success = { (dataTask: URLSessionDataTask, responseObject: Any?) -> Void in
            finished(responseObject, nil)
        }
        
        // 定义请求失败的闭包
        let failure = { (dataTask: URLSessionDataTask?, error: Error) -> Void in
            finished(nil, error)
        }
        
        if method == .GET {
            get(urlString,parameters:parameters,progress:nil,success:success,failure:failure)
        }else{
            post(urlString, parameters: parameters, progress: nil, success:success, failure: failure)
        }
    }
    
    func requestBack(method: AFRequestMethod = .GET, urlString: String, parameters: AnyObject?, finished:@escaping AFNRequestCallBack) -> URLSessionDataTask{
        
        print("urlString ============  " + urlString)
        print("parameters ============  " + String(describing: parameters))
        
        // dataTaskWithHttp 是写在 .m 文件里面的
        // 对应在 Swift 中的，就是 private 修饰的方法
        
        // 定义请求成功的闭包
        let success = { (dataTask: URLSessionDataTask, responseObject: Any?) -> Void in
            finished(responseObject, nil)
        }
        
        // 定义请求失败的闭包
        let failure = { (dataTask: URLSessionDataTask?, error: Error) -> Void in
            finished(nil, error)
        }
        
        if method == .GET {
            return get(urlString,parameters:parameters,progress:nil,success:success,failure:failure)!
        }else{
            return post(urlString, parameters: parameters, progress: nil, success:success, failure: failure)!
        }
    }
    
    
    /// 发送请求(上传文件)
    
    func requestWithData(data: NSData, name: String, urlString: String, parameters: AnyObject?, finished:@escaping AFNRequestCallBack) {
        // 定义请求成功的闭包
        let success = { (dataTask: URLSessionDataTask, responseObject: AnyObject?) -> Void in
            finished(responseObject, nil)
        }
        
        // 定义请求失败的闭包
        let failure = { (dataTask: URLSessionDataTask?, error: NSError) -> Void in
            finished(nil, error)
        }
        
        post(urlString, parameters: parameters, constructingBodyWith: { (formData) -> Void in
            formData.appendPart(withFileData: data as Data, name: name, fileName: "aa", mimeType: "application/octet-stream")
        }, progress: nil, success: success as? (URLSessionDataTask, Any?) -> Void, failure: (failure as! (URLSessionDataTask?, Error) -> Void))
    }
}
