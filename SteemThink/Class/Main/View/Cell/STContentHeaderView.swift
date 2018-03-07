//
//  STContentHeaderView.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/28.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STContentHeaderView: UIView {
    
    @IBOutlet weak var userIconImgV: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    
    var content:STContent?{
        didSet{
            // 姓名
            nameLab.text = content?.author
            
            // 日期
            let timeStr = content?.last_update.replacingOccurrences(of: "T", with: " ")
            timeLab.text = NSDate_STExtension.getDateLong(fromDate: timeStr!)
            
            // 标题
            titleLab.text = content?.root_title
            
            // 内容
            contentLab.text = content?.body
            
            // 头像 (通过authorName 获取个人信息列表)
            let url = "https://steemitimages.com/u/"+(content?.author)!+"/avatar"
            self.userIconImgV.sd_setImage(with: URL.init(string: url), placeholderImage: UIImage.init(named: "user_icon_placeholder"), completed: nil)
        }
    }
    
    func reloadFrame() -> Void {
        self.layoutIfNeeded()
        print("self.titleLab.frame"+NSStringFromCGRect(self.titleLab.frame))
        print("contentLab"+NSStringFromCGRect(self.contentLab.frame))
        self.frame = CGRect.init(x: 0, y: 0, width: screen_width, height: 63 + self.titleLab.frame.size.height + self.contentLab.frame.size.height)
    }
}
