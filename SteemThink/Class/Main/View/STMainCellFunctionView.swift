//
//  STMainCellFunctionView.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/26.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STMainCellFunctionView: UIView {
    
    @IBOutlet weak var dollarLab: UILabel!
    @IBOutlet weak var commentLab: UILabel!
    @IBOutlet weak var voteLab: UILabel!
    
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
}
