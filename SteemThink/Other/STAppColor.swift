//
//  AppColor.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/23.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import Foundation


/// 背景色
let kAppBgColor = UIColor.init(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 1)

/// 分割线颜色
let kSeparatorColor = UIColor.init(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 1)

/// 主题色
let kAppMainColor = UIColor(red:0.28, green:0.60, blue:0.92, alpha:1.00)

/// hex颜色
func colorWithHex(hex:NSInteger) -> UIColor {
    return colorWithHex(hex: hex, alpha: 1)
}

func colorWithHex(hex:NSInteger,alpha:CGFloat) -> UIColor {
    let red   = (CGFloat)((0xff0000 & hex) >> 16) / 255.0;
    let green = (CGFloat)((0xff00   & hex) >> 8)  / 255.0;
    let blue  = (CGFloat)(0xff      & hex)        / 255.0;
    return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
}
