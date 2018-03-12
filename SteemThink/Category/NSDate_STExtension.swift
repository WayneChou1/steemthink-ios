//
//  NSDate_STExtension.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/26.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class NSDate_STExtension: NSObject {

}

extension NSDate_STExtension{
    class func getDateLong(fromDate:String) -> String {
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let timeDate = dateFormatter.date(from: fromDate)
        
        // 如果无法格式化，直接返回空字符串
        if timeDate == nil {
            return ""
        }
        
        let zone = NSTimeZone.system
        let interval = zone.secondsFromGMT(for: timeDate!)
        let myDate = timeDate?.addingTimeInterval(TimeInterval(interval))
        let nowDate = Date().addingTimeInterval(TimeInterval(interval))
        // 两个时间间隔
        var timeInterval = myDate?.timeIntervalSince(nowDate)
        timeInterval = -timeInterval!
        var temp = 0
        if timeInterval! < 60 {
            return localizedString(key: "now", comment: "")
        }else if timeInterval!/60<60{
            temp = Int(timeInterval!/60)
            return String(format: "%d",temp) + localizedString(key: "minutes ago", comment: "")
        }else if timeInterval!/(60*60)<24{
            temp = Int(timeInterval!/(60*60))
            return String(format: "%d",temp) + localizedString(key: "hous ago", comment: "")
        }else if timeInterval!/(24*60*60)<30{
            temp = Int(timeInterval!/(24*60*60))
            return String(format: "%d",temp) + localizedString(key: "days ago", comment: "")
        }else if timeInterval!/(24*60*60*30)<12{
            temp = Int(timeInterval!/(24*60*60*30))
            return String(format: "%d",temp) + localizedString(key: "months ago", comment: "")
        }else{
            temp = Int(timeInterval!/(24*60*60*30*12))
            return String(format: "%d",temp) + localizedString(key: "years ago", comment: "")
        }
    }
}
