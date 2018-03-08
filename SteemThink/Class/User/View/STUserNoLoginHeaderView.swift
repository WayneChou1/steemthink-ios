//
//  STUserNoLoginHeaderView.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/3/1.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

protocol UserNoLoginDelegate:NSObjectProtocol {
    func userLogin()
}

class STUserNoLoginHeaderView: UIView {
    
    weak var delegate:UserNoLoginDelegate?
    
    @IBAction func loginBtnOnClick(_ sender: UIButton) {
        if delegate != nil {
            delegate?.userLogin()
        }
    }
}
