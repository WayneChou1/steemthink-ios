//
//  STWMPageViewController.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/27.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit
import WMPageController

class STWMPageViewController: WMPageController {
    
    let titleArr:[String]! = [localizedString(key: "New", comment: ""),localizedString(key: "Hot", comment: ""),localizedString(key: "Trending", comment: "")]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        self.setUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setUp() -> Void {
        self.titleSizeNormal = 15
        self.titleSizeSelected = 18
        self.menuView.style = WMMenuViewStyle.line
        self.menuItemWidth = 100.0
        self.titleColorSelected = kAppMainColor
        self.titleColorNormal = UIColor.black
        self.menuHeight = 35
        self.reloadData()
    }
    
    // MARK: - UINavigationBarappend
    func setUpNavigationBar() -> Void {
        let searchBar = UISearchBar.init(frame: CGRect.zero)
        searchBar.placeholder = localizedString(key: "Search", comment: "")
        self.navigationItem.titleView = searchBar
        
        // 导航栏放置UISearchBar 导航栏高度变高 (iOS 11)
        if #available(iOS 11.0, *) {
            searchBar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        }
        
        let postItem = UIBarButtonItem.init(image: UIImage.init(named: "main_post"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.postItemOnClick))
        let holderItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        self.navigationItem.rightBarButtonItems = [postItem,holderItem]
    }
    
    // MARK - Datasource & Delegate
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return titleArr.count
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        var VC:UIViewController?
        switch index {
        case 0:
            VC = STMainViewController.initWith(requestType: MainRequestType.New)
        case 1:
            VC = STMainViewController.initWith(requestType: MainRequestType.Hot)
        case 2:
            VC = STMainViewController.initWith(requestType: MainRequestType.Trending)
            break
        default: break

        }
        return VC!
//        return UIViewController.init()
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return titleArr[index]
    }

    // MARK: - ItemAction
    @objc func postItemOnClick() -> Void {
        let mainNav = STNavigationViewController.init(rootViewController: STPostArticalViewController())
        self.present(mainNav, animated: true, completion: nil)
    }
}
