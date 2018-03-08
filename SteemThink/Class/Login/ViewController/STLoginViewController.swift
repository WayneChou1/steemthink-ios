//
//  STLoginViewController.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/23.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit
import WebKit

protocol WKDelegateController:WKScriptMessageHandler {
    
}

class STLoginViewController: BaseViewController,WKUIDelegate,WKNavigationDelegate {

    var webView: WKWebView?
    
    deinit {
        self.removeWKWebViewCookies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = localizedString(key: "Login", comment: "")
        self.setUpWebView()
        self.setUpCloseItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setUpWebView() {
        //配置环境
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        configuration.userContentController = userContentController
        webView = WKWebView.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height), configuration: configuration)
        webView?.load(URLRequest.init(url: URL.init(string: get_login_url)!))
        webView?.uiDelegate = self;
        webView?.navigationDelegate = self
        self.view.addSubview(webView!)
    }
    
    func setUpCloseItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "login_close"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(closeItemOnClick))
    }
    
    //MARK: - WKNavigationDelegate
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    // 在发送请求之前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("RequestUrl ========"+(navigationAction.request.url?.absoluteString)!)
        //允许跳转
        decisionHandler(WKNavigationActionPolicy.allow)
        //不允许跳转
//        decisionHandler(WKNavigationActionPolicy.cancel)
    }
    // 在收到响应后，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("ResponseUrl ========"+(navigationResponse.response.url?.absoluteString)!)
        
        //不允许跳转
        if (navigationResponse.response.url?.absoluteString.contains("access_token"))! {
            UserDataManager.sharedInstance.saveUserInfo(fromStr: (navigationResponse.response.url?.absoluteString)!)
            decisionHandler(WKNavigationResponsePolicy.cancel);
            self.closeItemOnClick()
        }else{
            //允许跳转
            decisionHandler(WKNavigationResponsePolicy.allow);
        }
    }
    
    //MARK: - ItemOnClick
    @objc func closeItemOnClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //清除cookie
    func removeWKWebViewCookies(){
        
        //iOS9.0以上使用的方法
        if #available(iOS 9.0, *) {
            let dataStore = WKWebsiteDataStore.default()
            dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: { (records) in
                for record in records{
                    //清除本站的cookie
//                    if record.displayName.contains("steemconnect.com"){//这个判断注释掉的话是清理所有的cookie
                        WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {
                            //清除成功
                            print("清除成功\(record)")
                        })
//                    }
                }
            })
        } else {
            //ios8.0以上使用的方法
            let libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
            let cookiesPath = libraryPath! + "/Cookies"
            try!FileManager.default.removeItem(atPath: cookiesPath)
        }
    }
}
