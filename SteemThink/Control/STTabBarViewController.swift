//
//  STTabBarViewController.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/27.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSubNav()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setUpSubNav() -> Void {
        self.viewControllers = self.createControllers()
    }
    
    func createControllers() -> [UIViewController] {
        
        // 图片偏离
        let imageEdge = UIEdgeInsetsMake(6, 0, -6, 0)
        
        // 获取Nav
        let mainNav = STNavigationViewController.init(rootViewController: STWMPageViewController.init())
        let mainNavItem = UITabBarItem.init(title: nil, image: UIImage.init(named: "tabbar_home_normal")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage.init(named: "tabbar_home_select")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        mainNavItem.imageInsets = imageEdge
        mainNav.tabBarItem = mainNavItem
        
        let searchNav = STNavigationViewController.init(rootViewController: STSearchViewController.init())
        let searchNavItem = UITabBarItem.init(title: nil, image: UIImage.init(named: "tabbar_search_normal")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage.init(named: "tabbar_search_select")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        searchNavItem.imageInsets = imageEdge
        searchNav.tabBarItem = searchNavItem
        
        let userNav = STNavigationViewController.init(rootViewController: STUserViewController.initWithStortBorad(nibName: "STUserStoryboard"))
        let userNavItem = UITabBarItem.init(title: nil, image: UIImage.init(named: "tabbar_user_normal")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage.init(named: "tabbar_user_select")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        userNavItem.imageInsets = imageEdge
        userNav.tabBarItem = userNavItem
        
        return [mainNav,searchNav,userNav]
    }
}
