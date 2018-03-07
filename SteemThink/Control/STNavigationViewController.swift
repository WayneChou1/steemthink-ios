//
//  STNavigationViewController.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/26.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STNavigationViewController: UINavigationController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        //MARK: - 添加返回手势
        if self.responds(to: #selector(getter: self.interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.delegate = self
            self.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initialize() -> Void {
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = kAppMainColor
        // 设置标题样式
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black,
                                                  NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count >= 1 {
            // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
            /* 设置导航栏上面的内容 */
            // 设置左边的返回按钮
            let spaceItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
            spaceItem.width = -20
            let backItem = UIBarButtonItem.init(image: UIImage.init(named: "steemit_back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftItemOnClick))
            viewController.navigationItem.leftBarButtonItems = [backItem,spaceItem]
            viewController.hidesBottomBarWhenPushed = true
        }
        
        if self.responds(to: #selector(getter: self.interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    //MARK: - UINavigationDelegate
    //UINavigationControllerDelegate方法
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //实现滑动返回功能
        //清空滑动返回手势的代理就能实现
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer!.isEnabled = false
        }
        else {
            self.interactivePopGestureRecognizer!.isEnabled = true
        }
    }
    
    //MARK: - Action
    @objc func leftItemOnClick() -> Void {
        self.popViewController(animated: true)
    }
}
