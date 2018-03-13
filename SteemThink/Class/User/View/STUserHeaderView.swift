//
//  STUserHeaderView.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/3/1.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STUserHeaderView: UIView {
    
    @IBOutlet weak var userIconImageV: UIImageView!
    @IBOutlet weak var nickNameLab: UILabel!
    
    var userName:String?{
        didSet{
            if  userName != nil {
                // 头像 (通过authorName 获取个人信息列表)(UserIcon)
                let url = "https://steemitimages.com/u/" + userName! + "/avatar"
                self.userIconImageV.sd_setImage(with: URL.init(string: url), placeholderImage: UIImage.init(named: "user_icon_placeholder_large"), completed: nil)
                
                // 获取昵称
                self.getUserName(authorName: userName!, handler: { (userNameFromNet:String?) in
                    self.nickNameLab.text = userNameFromNet
                })
            }
        }
    }
    
    func getUserName(authorName:String,handler:@escaping (_ userName:String?)-> Void) {
        
        let author = [authorName]
        let jsonStr = NSArray_STExtension.getJSONStringFromArray(array:author as [AnyObject])
        let url = get_accounts + jsonStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        STAFNetworkTools.sharedTools.request(method: .GET, urlString: url, parameters: nil) { (response: Any?,error: Error?) in
            if response is NSArray{
                for dic:Dictionary in response as! [Dictionary<String, Any>]{
                    let user:STUser = STUser.init(dict: dic)
                    if let name = user.json_meta?.user_profile?.name {
                        handler(name)
                    }else{
                        handler(self.userName)
                    }
                    break;
                }
            }
        }
    }
}
