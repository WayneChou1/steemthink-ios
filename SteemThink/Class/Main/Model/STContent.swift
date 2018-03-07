//
//  STTrending.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/24.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STMetaData: STBaseModel {
    var links:[String]? = []
    var image:[String]? = []
    var tags:[String]? = []
    var app : String = ""
    var format : String = ""
    var community : String = ""
}

@objcMembers

class STContentBeneficiary: STBaseModel {
    var account : String = ""
    var weight : Int32 = 0

}

@objcMembers

class STContentActiveVotes: STBaseModel {
    var voter : String = ""
    var weight : Int32 = 0
    var rshares : Int32 = 0
    var percent : Int32 = 0
    var reputation : Int32 = 0
    var time : String = ""
}

@objcMembers

class STContent: STBaseModel {
    var id : Int32 = 0
    var depth : Int32 = 0
    var children : Int32 = 0
    var total_vote_weight : Int32 = 0
    var reward_weight : Int32 = 0
    var author_rewards : Int32 = 0
    var net_votes : Int32 = 0
    var percent_steem_dollars : Int32 = 0
    var body_length : Int32 = 0
    var net_rshares : Int32 = 0
    var abs_rshares : Int32 = 0
    var vote_rshares : Int32 = 0
    var children_abs_rshares : Int32 = 0
    var author_reputation : Int32 = 0
    var author : String = ""
    var permlink : String = ""
    var category : String = ""
    var parent_permlink : String = ""
    var title : String = ""
    var body : String = ""
    var json_metadata : String = ""
    var last_update : String = ""
    var created : String = ""
    var active : String = ""
    var last_payout : String = ""
    var cashout_time : String = ""
    var max_cashout_time : String = ""
    var total_payout_value : String = ""
    var curator_payout_value : String = ""
    var root_author : String = ""
    var root_permlink : String = ""
    var max_accepted_payout : String = ""
    var allow_replies : Bool = false
    var allow_votes : Bool = false
    var allow_curation_rewards : Bool = false
    var beneficiaries : [Dictionary<String, Any>]?
    var url : String = ""
    var root_title : String = ""
    var pending_payout_value : String = ""
    var total_pending_payout_value : String = ""
    var active_votes : [Dictionary<String, Any>]?
    var promoted : String = ""
    var beneficiaries_arr : [STContentBeneficiary]? = []
    var active_votes_arr : [STContentActiveVotes]? = []
    var json_meta : STMetaData?
    
    override init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        // beneficiary
        for dicBeneficiary:Dictionary in self.beneficiaries!{
            // 遍历得到Model
            let beneficiary = STContentBeneficiary.init(dict: dicBeneficiary)
            self.beneficiaries_arr?.append(beneficiary)
        }
        // vote
        for dicVote:Dictionary in self.active_votes!{
            // 遍历得到Model
            let vote = STContentActiveVotes.init(dict: dicVote)
            self.active_votes_arr?.append(vote)
        }
        
        //json_meta
        self.json_meta = STMetaData.init(dict: NSDictionary_STExtension.getDictionaryFromJSONString(jsonString: self.json_metadata) as! [String : Any])
    }
}
