//
//  STBaseTableViewCell.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/24.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STBaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    class public func cellIdentifier() -> String{
        return String(describing: type(of:STBaseTableViewCell()))
    }
}
