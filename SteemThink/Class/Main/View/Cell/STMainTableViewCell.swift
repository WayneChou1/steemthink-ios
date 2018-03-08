//
//  STMainTableViewCell.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/24.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit
import SDWebImage

protocol STMainCellDelegate:NSObjectProtocol {
    func voteWithIndexPath(indexPath:IndexPath)
}

class STMainTableViewCell: STBaseTableViewCell,STMainFuncDelegate {
    
    @IBOutlet weak var userIconImgV: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var functionView: STMainCellFunctionView!
    
    var indexPath:IndexPath?
    weak var delegate:STMainCellDelegate?
    
    var content:STContent?{
        didSet{
            
            // 姓名（Name）
            nameLab.text = content?.author
            
            // 日期 (Date)
//            let timeStr = content?.last_update.replacingOccurrences(of: "T", with: " ")
            timeLab.text = NSDate_STExtension.getDateLong(fromDate: (content?.last_update)!)
            
            // 标题 (Title)
            titleLab.text = content?.root_title
            
            // 内容 (Content)
            contentLab.text = content?.body
            
            // 头像 (通过authorName 获取个人信息列表)(UserIcon)
            let url = "https://steemitimages.com/u/"+(content?.author)!+"/avatar"
            self.userIconImgV.sd_setImage(with: URL.init(string: url), placeholderImage: UIImage.init(named: "user_icon_placeholder"), completed: nil)
            
            functionView.content = content
            functionView.delegate = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - STMainFuncDelegate
    
    func voteOnTap() {
        if delegate != nil && indexPath != nil{
            delegate?.voteWithIndexPath(indexPath: indexPath!)
        }
    }
    
    
//    func getIconUrl(authorName:String,handler:@escaping (_ iconUrl:String)-> Void) {
//
//        // 取消掉下载任务
//        task?.cancel()
//
//        let author = [authorName]
//        let jsonStr = NSArray_STExtension.getJSONStringFromArray(array:author as [AnyObject])
//        let url = get_accounts + "names[]=" + jsonStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        task = STAFNetworkTools.sharedTools.requestBack(method: .GET, urlString: url, parameters: nil) { (response: Any?,error: Error?) in
//            if response is NSArray{
//                for dic:Dictionary in response as! [Dictionary<String, Any>]{
//                    let user:STUser = STUser.init(dict: dic)
//                    if let url = user.json_meta?.user_profile?.profile_image {
//                        handler(url)
//                    }else{
//                        handler("")
//                    }
//                    break;
//                }
//            }
//        }
//    }
    
}
