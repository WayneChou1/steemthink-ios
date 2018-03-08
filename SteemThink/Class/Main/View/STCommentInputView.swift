//
//  STCommentInputView.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/3/2.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit
import SnapKit

let maxHeight:CGFloat = 100

class STCommentInputView: UIView,UITextViewDelegate {
    
    typealias STCommentInputHandler = (_ comment:String?)->()

    var textView:UITextView = {
        let commontTV = UITextView.init(frame: CGRect.zero)
        commontTV.font = kfont(size:15.0)
        commontTV.textColor = UIColor.black
        commontTV.backgroundColor = colorWithHex(hex: 0xE5EDF1)
        commontTV.returnKeyType = UIReturnKeyType.send
        return commontTV
    }()
    var placeholder:UILabel = {
        let commontPlaceholder = UILabel()
        commontPlaceholder.text = "请输入评论"
        commontPlaceholder.textAlignment = NSTextAlignment.left
        commontPlaceholder.textColor = UIColor.init(white: 0.8, alpha: 1)
        return commontPlaceholder
    }()
    
    var handler:STCommentInputHandler?
    
    var placeString:String?
    var currentSize:CGSize?
    
    init(frame: CGRect,handler:@escaping STCommentInputHandler) {
        super.init(frame: frame)
        self.setUpSubViews()
        self.handler = handler
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 切圆角
        self.textView.layer.cornerRadius = 2.0
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        // 添加约束
        self.textView.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.top.equalTo(self.snp.top).offset(5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        })
        
        self.placeholder.snp.makeConstraints({ (make) in
            make.height.equalTo(self.textView.snp.height)
            make.width.equalTo(200)
            make.left.equalTo(self.textView.snp.left).offset(10)
            make.top.equalTo(self.textView.snp.top)
        })
    }
    
    func setUpSubViews() {
        
        self.addSubview(self.textView)
        self.textView.delegate = self
        self.textView.addSubview(self.placeholder)
        
        self.updateConstraints()
        self.layoutIfNeeded()
        
        // 注册键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(noti:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    //MARK: - 通知
    @objc func keyboardWillShow(noti:NSNotification) {
        let rect = noti.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        let height = rect.size.height
        let animationTime = noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        UIView.animate(withDuration: TimeInterval(animationTime)) {
            self.frame = CGRect.init(x: 0, y: screen_height - height - self.frame.size.height, width: screen_width, height: self.frame.size.height)
        }
    }
    @objc func keyboardWillHide(noti:NSNotification) {
        let animationTime = noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        UIView.animate(withDuration: TimeInterval(animationTime)) {
            self.frame = CGRect.init(x: 0, y: screen_height - self.frame.size.height, width: screen_width, height: self.frame.size.height)
        }
    }
    @objc func keyboardDidHide(noti:NSNotification) {
        
    }
    
    //MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text.elementsEqual("\n") {
            if self.handler != nil && text.count != 0{
                self.handler!(textView.text)
                textView.text = ""
            }
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        //判断占位符是否显示
        if textView.text.count == 0{
            if placeString != nil {
                placeholder.text = placeString
            }else{
                placeholder.text = "输入文字信息"
            }
        }else{
            placeholder.text = ""
        }
        
        // 判断textView的高度
        let textViewFrame:CGRect = textView.frame
        let textViewSize:CGSize = textView.sizeThatFits(CGSize.init(width: textViewFrame.width, height: 1000.0))
        
        // 判断是否可以滚动
        textView.isScrollEnabled = textViewSize.height - 10.0 > maxHeight
        
        // 控制富视图的高度
        var parentRect:CGRect = self.frame
        if textViewSize.height != currentSize?.height {
            parentRect.size.height = self.frame.size.height + (textViewSize.height - textViewFrame.size.height)
            parentRect.origin.y = self.frame.origin.y - (textViewSize.height - textViewFrame.size.height)
            self.frame = parentRect
        }
        
        currentSize = textViewSize
    }
}
