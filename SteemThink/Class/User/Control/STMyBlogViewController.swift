//
//  STMyBlogViewController.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/3/13.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit
import MJRefresh

class STMyBlogViewController: UITableViewController {
    
    lazy var dataSource:[STContent] = {
        let source:[STContent] = []
        return source
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = localizedString(key: "My Questions", comment: "")
        self.setUpTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        let dict = ["tag":UserDataManager.sharedInstance.getUserName(), "limit": "50"]
        let jsonStr = NSDictionary_STExtension.getJSONStringFromDictionary(dictionary: dict)
        let url = get_discussions_by_blog + jsonStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
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

}
