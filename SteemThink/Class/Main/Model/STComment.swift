//
//  STComment.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/3/1.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

@objcMembers
class STComment: STBaseModel {
    var id : Int32 = 0
    var children : Int32 = 0
    var author : String = ""
    var permlink : String = ""
    var category : String = ""
    var parent_author : String = ""
    var parent_permlink : String = ""
    var body : String = ""
    var json_metadata : String = ""
    var last_update : String = ""
    var created : String = ""
    var active : String = ""
    var url : String = ""
    var pending_payout_value : String = ""
    var active_votes : [Dictionary<String, Any>]?
    var beneficiaries : [Dictionary<String, Any>]?
    var beneficiaries_arr : [STContentBeneficiary]? = []
    var active_votes_arr : [STContentActiveVotes]? = []
    var json_meta : STMetaData?
    
    //用来判断是否正使用此模型来网络请求
    var loading:Bool = false
    
    override init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        // beneficiary
        if self.beneficiaries != nil {
            for dicBeneficiary:Dictionary in self.beneficiaries!{
                // 遍历得到Model
                let beneficiary = STContentBeneficiary.init(dict: dicBeneficiary)
                self.beneficiaries_arr?.append(beneficiary)
            }
        }
        
        if self.active_votes != nil {
            // vote
            for dicVote:Dictionary in self.active_votes!{
                // 遍历得到Model
                let vote = STContentActiveVotes.init(dict: dicVote)
                self.active_votes_arr?.append(vote)
            }
        }
        
        
        //json_meta
        self.json_meta = STMetaData.init(dict: NSDictionary_STExtension.getDictionaryFromJSONString(jsonString: self.json_metadata) as! [String : Any])
    }
}
