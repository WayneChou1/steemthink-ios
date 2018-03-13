//
//  STMainCellFunctionView.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/26.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STMainFunctionItem: UIView {
    
    lazy var DesImgV: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = colorWithHex(hex: 0x707070)
        lab.font = kfont(size: 13.0)
        return lab
    }()
    
    lazy var activity:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activity.color = kAppMainColor
        activity.hidesWhenStopped = true
        activity.isHidden = true
        return activity
    }()
    
    var selector:Selector?
    var target:Any?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpSubViews()
        
        // 添加单机手势
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(itemTap))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        // 添加约束
        self.titleLab.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX).offset(13)
        })
        self.DesImgV.snp.makeConstraints({ (make) in
            make.width.equalTo(25.0)
            make.height.equalTo(25.0)
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.titleLab.snp.left).offset(-5.0)
        })
        self.activity.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLab.snp.right).offset(10.0)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    func setUpSubViews() {
        self.addSubview(self.titleLab)
        self.addSubview(self.DesImgV)
        self.addSubview(self.activity)
        self.updateConstraints()
    }
    
    func setSubViews(title:String,imageName:String) {
        self.setSubViews(title: title, imageName: imageName, target: nil, selector: nil)
    }
    
    func setSubViews(title:String,imageName:String,target:Any?,selector:Selector?) {
        titleLab.text = title
        DesImgV.image = UIImage.init(named: imageName)
        self.selector = selector
        self.target = target
    }
    
    //MARK: - 菊花动画
    func showActivityAnimate(isAnimate:Bool) {
        if isAnimate {
            self.activity.startAnimating()
        }else{
            self.activity.stopAnimating()
        }
    }
    
    //MARK: - 单机手势
    @objc func itemTap() {
        if self.target != nil && self.selector != nil {
            (self.target! as AnyObject).perform(self.selector!, with: self, afterDelay: 0.0)
        }
    }
}

class STMainCellFunctionView: UIView {
    
    var items:[STMainFunctionItem]?
    
    func setFunctionItem(items:[STMainFunctionItem]) {
        
        self.items = items
        // 添加视图
        for item in items {
            self.addSubview(item)
        }
        
        // 添加约束
        for (idx, item) in items.enumerated() {
            item.snp.makeConstraints({ (make) in
                // left
                if idx == 0{
                    make.left.equalTo(self.snp.left).offset(0)
                }else{
                    make.left.equalTo(items[idx - 1].snp.right).offset(0)
                    //width
                    make.width.equalTo(items[idx - 1].snp.width)
                }
                
                // right
                if idx == items.count - 1 {
                    make.right.equalTo(self.snp.right).offset(0)
                }else{
                    make.right.equalTo(items[idx + 1].snp.left).offset(0)
                }
                
                // top
                make.top.equalTo(self.snp.top).offset(0)
                // bottom
                make.bottom.equalTo(self.snp.bottom).offset(0)
            })
        }
    }
}
