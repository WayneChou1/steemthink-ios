//
//  STContentDetailTableViewCell.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/28.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STContentDetailTableViewCell: STBaseTableViewCell {
    
    @IBOutlet weak var userIconImgV: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var functionView: STMainCellFunctionView!
    
    var comment:STComment?{
        didSet{
            
            // 姓名（Name）
            nameLab.text = comment?.author
            
            // 日期 (Date)
//            let timeStr = comment?.created.replacingOccurrences(of: "T", with: " ")
            timeLab.text = NSDate_STExtension.getDateLong(fromDate: (comment?.created)!)
            
            // 内容 (Content)
            contentLab.text = comment?.body
            
            // 头像 (通过authorName 获取个人信息列表)(UserIcon)
            let url = "https://steemitimages.com/u/"+(comment?.author)!+"/avatar"
            self.userIconImgV.sd_setImage(with: URL.init(string: url), placeholderImage: UIImage.init(named: "user_icon_placeholder"), completed: nil)
            
            let sbd = comment?.pending_payout_value.components(separatedBy: " ").first
            functionView.dollarLab.text = " " + "\(String(describing: sbd!))"
            functionView.voteLab.text = String(format: "%d",(comment?.active_votes_arr?.count)!)
            functionView.commentLab.text = String(format: "%d",(comment?.children)!)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
