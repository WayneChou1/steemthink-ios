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
    
    var favor:Bool = false
    var indexPath:IndexPath?
    var comment:STComment?{
        didSet{
            
            // 重置点赞
            favor = false
            
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
            
//            let sbd = comment?.pending_payout_value.components(separatedBy: " ").first
//            functionView.dollarLab.text = " " + "\(String(describing: sbd!))"
//            functionView.voteLab.text = String(format: "%d",(comment?.active_votes_arr?.count)!)
//            functionView.commentLab.text = String(format: "%d",(comment?.children)!)
            self.setFunctionData(comment: comment!)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpFunctionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpFunctionView() {
        functionView.setFunctionItem(items: [STMainFunctionItem(),STMainFunctionItem()])
    }
    
    // MARK: - 填充function数据
    func setFunctionData(comment:STComment?) {
        let sbd = comment?.pending_payout_value.components(separatedBy: " ").first
        let dolerStr = " " + "\(String(describing: sbd!))"
        let item1 = functionView.items![0]
        item1.setSubViews(title: dolerStr, imageName: "main_doller")
        
//        let commentStr = String(format: "%d",(content?.children)!)
//        let item2 = functionView.items![1]
//        item2.setSubViews(title: commentStr, imageName: "main_comment")
        
        let voteStr = String(format: "%d",(comment?.active_votes_arr?.count)!)
        let item2 = functionView.items![1]
        item2.showActivityAnimate(isAnimate: (comment?.loading)!)
        
        if UserDataManager.sharedInstance.isLogin() {
            for vote in (comment?.active_votes_arr)! {
                if vote.voter == UserDataManager.sharedInstance.getUserName(){
                    favor = true
                    break
                }
            }
        }
        let imageName = favor ? "main_vote":"main_unvote"
        item2.setSubViews(title: voteStr, imageName: imageName, target: self, selector: #selector(voteViewOnTap))
    }
    
    //MARK: - Vote
    @objc func voteViewOnTap() {
        if self.favor {
            comment?.loading = true
            let idx = self.indexPath
            STClient.vote(voter: UserDataManager.sharedInstance.getUserName(), author: comment!.author, permlink: comment!.permlink, weight: 10000, to:nil) { (response, error) in
                self.comment?.loading = false
                if error != nil && idx == self.indexPath{
                    self.voteAnimate()
                }
            }
        }
    }
    
    //MARK: - Animate
    func voteAnimate() {
        
        // 如果已经点赞忽略
        if self.favor {
            return
        }
        
        // 插入点赞的模型（本人点赞）
        let mineVote = STContentActiveVotes()
        mineVote.voter = UserDataManager.sharedInstance.getUserName()
        self.comment?.active_votes_arr?.append(mineVote)
        
        // 刷新点赞个数
        let item3 = functionView.items![1]
        item3.titleLab.text = String(format: "%d",(comment?.active_votes_arr?.count)!)
        
        // 点赞动画
        UIView.animate(withDuration: 0.3, animations: {
            let newTransform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            item3.DesImgV.transform = newTransform
            item3.DesImgV.alpha = 0.5
        }) { (finished) in
            //            if self.favor {
            //                self.voteImgV.image = UIImage.init(named: "main_unvote")
            //            }else{
            item3.DesImgV.image = UIImage.init(named: "main_vote")
            //            }
            
            self.favor = !self.favor
            
            UIView.animate(withDuration: 0.3, animations: {
                item3.DesImgV.transform = CGAffineTransform.identity
                item3.DesImgV.alpha = 1
            })
        }
    }
    
}
