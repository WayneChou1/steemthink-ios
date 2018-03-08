//
//  STTextView.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/3/7.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STTextView: UITextView {

    var myPlaceholder:NSString?{
        didSet{
            self.placeholderLabel?.text = (myPlaceholder! as String)
            self.setNeedsLayout()
        }
    }
    var myPlaceholderColor:UIColor?
    
    private var placeholderLabel:UILabel?
    
    // 重写text
    override var text: String!{
        didSet{
            self.textDidChange()
        }
    }
    // 重写attributedText
    override var attributedText: NSAttributedString!{
        didSet{
            self.textDidChange()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.setUpLab()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let y:CGFloat = 8.0; //设置UILabel 的 y值
        let x:CGFloat = 5.0;//设置 UILabel 的 x 值
        let width = self.frame.size.width - x*2.0; //设置 UILabel 的 x
        
        //根据文字计算高度
        let maxSize = CGSize.init(width: width, height: CGFloat(MAXFLOAT));
        let height = self.myPlaceholder?.boundingRect(with: maxSize, options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.RawValue(UInt8(NSStringDrawingOptions.usesFontLeading.rawValue) | UInt8(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue))), attributes: [NSAttributedStringKey.font:kfont(size: 14)], context: nil).size.height
        
        self.placeholderLabel?.frame = CGRect.init(x: x, y: y, width: width, height: height!)
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder:aDecoder)
        self.setUpLab()
    }
    
    func setUpLab() {
        self.backgroundColor = UIColor.white
        self.font = kfont(size: 14)
        
        self.placeholderLabel = UILabel()
        self.placeholderLabel?.backgroundColor = UIColor.clear
        self.placeholderLabel?.numberOfLines = 0
        self.placeholderLabel?.font = kfont(size: 14)//默认占位符字体
        self.placeholderLabel?.textColor = colorWithHex(hex: 0xC9C9CD)//设置占位文字默认颜色
        self.addSubview(self.placeholderLabel!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
    @objc func textDidChange() {
        self.placeholderLabel?.isHidden = self.hasText
    }
}
