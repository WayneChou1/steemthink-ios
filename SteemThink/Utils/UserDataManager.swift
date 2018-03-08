//
//  UserDataManager.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/3/1.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

struct UserDataLogin {
    static let st_user_data_login = "st_user_data_login"
    static let st_user_data_logout = "st_user_data_logout"
}

struct UserDataSaveConstants {
    static let st_access_token_save = "st_access_token"
    static let st_userName_save = "st_userName"
    static let st_expires_in_save = "st_expires_in"
}

struct UserDataGetConstants {
    static let st_access_token = "access_token"
    static let st_userName = "username"
    static let st_expires_in = "expires_in"
}

class UserDataManager: NSObject {
    
    //MARK: - 单例
    static let sharedInstance:UserDataManager = {
        let instance = UserDataManager()
        return instance
    }()
    
    func isLogin() -> Bool {
        if userDefault().object(forKey: UserDataSaveConstants.st_access_token_save) != nil {
            return true
        }
        return false
    }
    
    //MARK: - 获取token
    func getToken() -> String {
        return userDefault().object(forKey: UserDataSaveConstants.st_access_token_save) as! String
    }
    
    //MARK: - 获取用户名
    func getUserName() -> String {
        return userDefault().object(forKey: UserDataSaveConstants.st_userName_save) as! String
    }
    
    //MARK: - 退出登录
    func logout() {
        userDefault().removeObject(forKey: UserDataSaveConstants.st_userName_save)
        userDefault().removeObject(forKey: UserDataSaveConstants.st_access_token_save)
        userDefault().removeObject(forKey: UserDataSaveConstants.st_expires_in_save)
        userDefault().synchronize()
        
        NotificationCenter.default.post(name: NSNotification.Name(UserDataLogin.st_user_data_logout), object: nil, userInfo:nil)
    }
    
    //MARK: - 保存用户信息
    func saveUserInfo(fromStr:String) {
        // 用户名
        if  let userName = self.paramValueOfUrl(url: fromStr, param: UserDataGetConstants.st_userName) {
            userDefault().set(userName, forKey: UserDataSaveConstants.st_userName_save)
        }
        
        if  let access_token = self.paramValueOfUrl(url: fromStr, param: UserDataGetConstants.st_access_token) {
            userDefault().set(access_token, forKey: UserDataSaveConstants.st_access_token_save)
        }
        
        if  let expires_in = self.paramValueOfUrl(url: fromStr, param: UserDataGetConstants.st_expires_in) {
            userDefault().set(expires_in, forKey: UserDataSaveConstants.st_expires_in_save)
        }
        userDefault().synchronize()
        
        NotificationCenter.default.post(name: NSNotification.Name(UserDataLogin.st_user_data_login), object: nil, userInfo:nil)
    }
    
    //MARK: - 截取参数
    func paramValueOfUrl(url:String,param:String) -> String? {

        let regTags = String.init(format: "(^|&|\\?)+%@=+([^&]*)(&|$)", arguments: [param])
        do {
            let regex = try NSRegularExpression.init(pattern: regTags, options: NSRegularExpression.Options.caseInsensitive)
            // 执行匹配的过程
            let matches = regex.matches(in: url, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange.init(location: 0, length: url.count))
            print("matches.count" + String.init(format: "%d", matches.count))
            for mactch:NSTextCheckingResult in matches {
                // 分组2所对应的串
                let tagValue = (url as NSString).substring(with: mactch.range(at: 2))
                return tagValue
            }
        } catch {}
        
        return nil
    }
}
