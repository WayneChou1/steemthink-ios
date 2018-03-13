//
//  STMainTableViewCell.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/24.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit
import SDWebImage

class STMainTableViewCell: STBaseTableViewCell {
    
    @IBOutlet weak var userIconImgV: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var functionView: STMainCellFunctionView!
    
    var favor:Bool = false
    var indexPath:IndexPath?
    
    var content:STContent?{
        didSet{
            
            // 重置点赞
            favor = false
            
            // 姓名（Name）
            nameLab.text = content?.author
            
            // 日期 (Date)
            timeLab.text = NSDate_STExtension.getDateLong(fromDate: (content?.last_update)!)
            
            // 标题 (Title)
            titleLab.text = content?.root_title
            
            // 内容 (Content)
            contentLab.text = content?.body
            
            // 头像 (通过authorName 获取个人信息列表)(UserIcon)
            let url = "https://steemitimages.com/u/"+(content?.author)!+"/avatar"
            self.userIconImgV.sd_setImage(with: URL.init(string: url), placeholderImage: UIImage.init(named: "user_icon_placeholder"), completed: nil)
            
            self.setFunctionData(content: content)
        }
    }
    
//    var searchResult:STSearchResult?{
//        didSet{
//            // 姓名（Name）
//            nameLab.text = searchResult?.author
//            
//            // 日期 (Date)
//            timeLab.text = NSDate_STExtension.getDateLong(fromDate: (searchResult?.created)!)
//            
//            // 标题 (Title)
//            titleLab.text = searchResult?.title
//            
//            // 内容 (Content)
//            contentLab.text = searchResult?.summary
//            
//            // 头像 (通过authorName 获取个人信息列表)(UserIcon)
//            let url = "https://steemitimages.com/u/"+(searchResult?.author)!+"/avatar"
//            self.userIconImgV.sd_setImage(with: URL.init(string: url), placeholderImage: UIImage.init(named: "user_icon_placeholder"), completed: nil)
//            self.setFunctionData(searchResult: searchResult)
//        }
//    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpFunctionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpFunctionView() {
        functionView.setFunctionItem(items: [STMainFunctionItem(),STMainFunctionItem(),STMainFunctionItem()])
    }
    
    // MARK: - 填充function数据
    func setFunctionData(content:STContent?) {
        let sbd = content?.pending_payout_value.components(separatedBy: " ").first
        let dolerStr = " " + "\(String(describing: sbd!))"
        let item1 = functionView.items![0]
        item1.setSubViews(title: dolerStr, imageName: "main_doller")
        
        let commentStr = String(format: "%d",(content?.children)!)
        let item2 = functionView.items![1]
        item2.setSubViews(title: commentStr, imageName: "main_comment")
        
        let voteStr = String(format: "%d",(content?.active_votes_arr?.count)!)
        let item3 = functionView.items![2]
        item3.showActivityAnimate(isAnimate: (content?.loading)!)
        
        if UserDataManager.sharedInstance.isLogin() {
            for vote in (content?.active_votes_arr)! {
                if vote.voter == UserDataManager.sharedInstance.getUserName(){
                    favor = true
                    break
                }
            }
        }
        let imageName = favor ? "main_vote":"main_unvote"
        item3.setSubViews(title: voteStr, imageName: imageName, target: self, selector: #selector(voteViewOnTap(item:)))
    }
    
//    func setFunctionData(searchResult:STSearchResult?) {
//        let commentStr = String(format: "%d",(searchResult?.children)!)
//        let item1 = functionView.items![0]
//        item1.setSubViews(title: commentStr, imageName: "main_comment")
//
//        let voteStr = String(format: "%d",(searchResult?.net_votes)!)
//        let item2 = functionView.items![1]
//        item2.showActivityAnimate(isAnimate: (content?.loading)!)
//        item2.setSubViews(title: voteStr, imageName: "main_unvote", target: self, selector: #selector(voteViewOnTap(item:)))
//    }
    
    //MARK: - Vote
    @objc func voteViewOnTap(item:STMainFunctionItem) {
        if !self.favor {
            
            content?.loading = true
            item.showActivityAnimate(isAnimate: true)
            let idx = self.indexPath
            STClient.vote(voter: UserDataManager.sharedInstance.getUserName(), author: content!.author, permlink: content!.permlink, weight: 10000, to:nil) { (response, error) in
                self.content?.loading = false
                item.showActivityAnimate(isAnimate: false)
                if error == nil && idx == self.indexPath{
                    self.voteAnimate(item: item)
                }
            }
        }
    }
    
    //MARK: - Animate
    func voteAnimate(item:STMainFunctionItem) {

        // 如果已经点赞忽略
        if self.favor {
            return
        }

        // 插入点赞的模型（本人点赞）
        let mineVote = STContentActiveVotes()
        mineVote.voter = UserDataManager.sharedInstance.getUserName()
        self.content?.active_votes_arr?.append(mineVote)

        // 刷新点赞个数
        item.titleLab.text = String(format: "%d",(content?.active_votes_arr?.count)!)

        // 点赞动画
        UIView.animate(withDuration: 0.3, animations: {
            let newTransform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            item.DesImgV.transform = newTransform
            item.DesImgV.alpha = 0.5
        }) { (finished) in
//            if self.favor {
//                self.voteImgV.image = UIImage.init(named: "main_unvote")
//            }else{
                item.DesImgV.image = UIImage.init(named: "main_vote")
//            }

            self.favor = !self.favor

            UIView.animate(withDuration: 0.3, animations: {
                item.DesImgV.transform = CGAffineTransform.identity
                item.DesImgV.alpha = 1
            })
        }
    }
}
