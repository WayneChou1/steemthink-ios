//
//  MBProgress_STExtension.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/23.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit
import MBProgressHUD

let JLMBProgressMsgLoading : String = "正在加载..."
let JLMBProgressMsgError : String = "加载失败"
let JLMBProgressMsgSuccessful : String = "加载成功"
let JLMBProgressMsgNoMoreData : String = "没有更多数据了"
let JLMBProgressMsgTimeInterval : TimeInterval = 1.2

let font_size = CGFloat(15.0)
let opacity = CGFloat(0.85)

/// 提示类型
enum STMBProgress {
    case Successful
    case Error
    case Warning
    case Info
}

class MBProgress_STExtension {
    
}

//MARK: - 设置HUD的扩展
extension MBProgress_STExtension {
    /// 添加到一个视图，并选择是否显示动画
    class func ST_ShowHUDAddedToView(view : UIView, title : String, animated : Bool) -> MBProgressHUD {
        let HUD = MBProgressHUD.showAdded(to: view, animated: animated);
        HUD.label.font = UIFont.systemFont(ofSize: font_size)
        HUD.label.text = title
        HUD.bezelView.alpha = opacity
        return HUD
    }
    
    /// 有动画
    class func ST_ShowHUDAddToViewWithoutAnimate(view : UIView, title : String) -> MBProgressHUD {
        
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.label.font = UIFont.systemFont(ofSize: font_size)
        HUD.label.text = title
        HUD.bezelView.alpha = opacity
        return HUD
    }
    
    class func ST_ShowViewAfterSecond(title : String, view : UIView, afterSecond : TimeInterval) -> MBProgressHUD {
        
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.mode = MBProgressHUDMode.text
        HUD.label.font = UIFont.systemFont(ofSize: font_size)
        HUD.label.text = title
        HUD.bezelView.alpha = opacity
        HUD.hide(animated: true, afterDelay: afterSecond)
        return HUD
    }
    
    class func ST_ShowHUDHidAfterSecondWithMsgType(title : String, view : UIView, afterSecond : TimeInterval, msgType : STMBProgress) -> MBProgressHUD {
        
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.label.font = UIFont.systemFont(ofSize: font_size)
        let imageName = ST_imageNamedWithMsgType(msgType: msgType)
        
        HUD.customView = UIImageView(image: UIImage(named: imageName))
        HUD.label.text = title
        HUD.bezelView.alpha = opacity
        HUD.mode = MBProgressHUDMode.customView
        HUD.hide(animated: true, afterDelay: afterSecond)
        return HUD
    }
    
    /// 根据显示类型来选择背景图片
    class func ST_imageNamedWithMsgType(msgType : STMBProgress) -> String {
        var imageName = ""
        
        switch msgType {
        case .Successful:
            imageName = "bwm_hud_success"
        case .Error:
            imageName = "bwm_hud_error"
        case .Warning:
            imageName = "bwm_hud_warning"
        case .Info:
            imageName = "bwm_hud_info"
        }
        return imageName
    }
}

