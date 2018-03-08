//
//  STMainCellFunctionView.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/26.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

protocol STMainFuncDelegate:NSObjectProtocol {
    func voteOnTap()
}

class STMainCellFunctionView: UIView {
    
    @IBOutlet weak var dollarLab: UILabel!
    @IBOutlet weak var commentLab: UILabel!
    @IBOutlet weak var voteLab: UILabel!
    @IBOutlet weak var voteImgV: UIImageView!
    
    weak var delegate:STMainFuncDelegate?
    var favor = false
    var content:STContent?{
        didSet{
            // 每次都刷新favor的值
            favor = false
            
            let sbd = content?.pending_payout_value.components(separatedBy: " ").first
            dollarLab.text = " " + "\(String(describing: sbd!))"
            voteLab.text = String(format: "%d",(content?.active_votes_arr?.count)!)
            commentLab.text = String(format: "%d",(content?.children)!)
            
            if UserDataManager.sharedInstance.isLogin() {
                for vote in (content?.active_votes_arr)! {
                    if vote.voter == UserDataManager.sharedInstance.getUserName(){
                        favor = true
                        break
                    }
                }
            }
            voteImgV.image = favor ? UIImage.init(named: "main_vote"):UIImage.init(named: "main_unvote")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let containerView = UINib.init(nibName: String(describing: type(of:STMainCellFunctionView())), bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        containerView.frame = self.bounds
        self.addSubview(containerView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: - btnAction
    @IBAction func voteViewOnTap(_ sender: UITapGestureRecognizer) {
        if delegate != nil && !self.favor{
            delegate?.voteOnTap()
        }
        
        // 如果已经点赞忽略
        if self.favor {
            return
        }
        
        // 插入点赞的模型（本人点赞）
        let mineVote = STContentActiveVotes()
        mineVote.voter = UserDataManager.sharedInstance.getUserName()
        self.content?.active_votes_arr?.append(mineVote)
        
        // 刷新点赞个数
        voteLab.text = String(format: "%d",(content?.active_votes_arr?.count)!)
        
        // 点赞动画
        UIView.animate(withDuration: 0.3, animations: {
            let newTransform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            self.voteImgV.transform = newTransform
            self.voteImgV.alpha = 0.5
        }) { (finished) in
//            if self.favor {
//                self.voteImgV.image = UIImage.init(named: "main_unvote")
//            }else{
                self.voteImgV.image = UIImage.init(named: "main_vote")
//            }
            
            self.favor = !self.favor
            
            UIView.animate(withDuration: 0.3, animations: {
                self.voteImgV.transform = CGAffineTransform.identity
                self.voteImgV.alpha = 1
            })
        }
    }
}
