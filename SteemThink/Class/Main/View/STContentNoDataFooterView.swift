//
//  STContentNoDataFooterView.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/3/1.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STContentNoDataFooterView: UIView {
    
    @IBOutlet weak var detailLab: UILabel!
    
    func setUpText(text:String) -> Void {
        self.detailLab.text = text
    }
}
