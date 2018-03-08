//
//  STPostArticalViewController.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/3/7.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STPostArticalViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var textView: STTextView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = localizedString(key: "Post Artical", comment: "")
        self.textView.myPlaceholder = localizedString(key: "Please input your artical", comment: "") as NSString
        self.setNavItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setNavItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: localizedString(key: "Cancel", comment: ""), style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelItemOnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: localizedString(key: "Post", comment: ""), style: UIBarButtonItemStyle.plain, target: self, action: #selector(postItemOnClick))
        // 默认不可点击
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    //MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    
    //MARK: - ItemOnClick
    @objc func cancelItemOnClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func postItemOnClick() {
//        STClient.comment(parentAuthor: "", parentPermlink: "", author: UserDataManager.sharedInstance.getUserName(), permlink: permlink!, body: textView.text) { (response, error) in
//
//        }
    }
}
