//
//  STBaseModel.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/24.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STBaseModel: NSObject {
    // MARK:- 自定义构造函数
    override init() {
        
    }
    
    public init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
