//
//  STPrefix.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/26.
//  Copyright © 2018年 zijinph. All rights reserved.
//


let screen_width = UIScreen.main.bounds.size.width
let screen_height = UIScreen.main.bounds.size.height


// MARK: - 国际化
//NSLocalizedString(key, comment) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]
func localizedString(key:String,comment:String) -> String {
    return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
}

// MARK: - 保存用户信息数据
func userDefault() -> UserDefaults{
    return UserDefaults.standard
}

// 字体
func kfont(size:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
}


