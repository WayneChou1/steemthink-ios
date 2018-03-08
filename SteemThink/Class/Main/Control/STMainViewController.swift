//
//  ViewController.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/12.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit
import MJRefresh

enum MainRequestType: Int {
    case New = 0
    case Hot = 1
    case Trending = 2
}

class STMainViewController: UITableViewController,STMainCellDelegate {
    
    lazy var dataSource:[STContent] = {
        let source:[STContent] = []
        return source
    }()
    var requestType:MainRequestType?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
//        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - 初始化
    class func initWith(requestType:MainRequestType) -> STMainViewController {
        let VC = STMainViewController.init()
        VC.requestType = requestType
        return VC
    }
    
    //MARK: - 初始化TableView
    func setUpTableView() -> Void {
        self.tableView.tableFooterView = UIView.init()
        self.tableView.register(UINib.init(nibName:String(describing: type(of:STMainTableViewCell())), bundle: Bundle.main), forCellReuseIdentifier: STMainTableViewCell.cellIdentifier())
        self.tableView.estimatedRowHeight = 218
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12)
        
        self.tableView.mj_header = MJDIYHeader.init(refreshingBlock: {
            self.loadData()
        })
        self.tableView.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: {
        })
        self.tableView.mj_header.beginRefreshing()
    }
    
    //MARK: - 获取数据
    func loadData() -> Void {
        let dict = ["tag":"life", "limit": "50"]
        let jsonStr = NSDictionary_STExtension.getJSONStringFromDictionary(dictionary: dict)
        
        // 根据枚举类型选择URL
        var urlH:String?
        switch self.requestType! {
        case .New:
            urlH = discussions_by_created;
            break
        case .Hot:
            urlH = discussions_by_hot
            break
        case .Trending:
            urlH = discussions_by_trending
            break
        }
        let url = urlH! + "query=" + jsonStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        STClient.get(url: url, parameters: nil, to: nil) { (response: Any?,error: Error?) in
            
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshingWithNoMoreData()
            
            if !(error != nil) {
                if response is NSArray{
                    let arr3:NSArray = response as! NSArray
                    for dict3:Dictionary in arr3 as! [Dictionary<String, Any>]{
                        // 遍历得到Model
                        let trending = STContent.init(dict: dict3)
                        self.dataSource.append(trending)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - TableViewDelegate & TableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:STMainTableViewCell = tableView.dequeueReusableCell(withIdentifier: STMainTableViewCell.cellIdentifier(), for: indexPath) as! STMainTableViewCell
        cell.content = self.dataSource[indexPath.row]
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let content = self.dataSource[indexPath.row]
        let VC:STContentDetailViewController = UIStoryboard.init(name: "STBodyStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: STContentDetailViewController.classForCoder())) as! STContentDetailViewController
        VC.content = content
        VC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    //MARK: - STMainCellDelegate
    func voteWithIndexPath(indexPath: IndexPath) {
        print("点赞~~~~~~~~~~~")
        let content = self.dataSource[indexPath.row]
//        self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        STClient.vote(voter: UserDataManager.sharedInstance.getUserName(), author: content.author, permlink: content.permlink, weight: 10000) { (response, error) in
        }
    }
}

