//
//  STSearchViewController.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/27.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit
import MJRefresh

class STSearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    lazy var dataSource:[STSearchResult] = {
        let source:[STSearchResult] = []
        return source
    }()
    
    var searchBar:UISearchBar?
    var page:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = localizedString(key: "Search", comment: "")
        self.setUpNavigationBar()
        self.setUpTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UINavigationBarappend
    func setUpNavigationBar() -> Void {
        self.searchBar = UISearchBar.init(frame: CGRect.zero)
        self.searchBar?.placeholder = localizedString(key: "Search", comment: "")
        self.searchBar?.delegate = self
        self.navigationItem.titleView = searchBar
        
        // 导航栏放置UISearchBar 导航栏高度变高 (iOS 11)
        if #available(iOS 11.0, *) {
            self.searchBar?.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        }
        
        // 弹出键盘
        self.searchBar?.becomeFirstResponder()
    }
    
    
    //MARK: - 初始化TableView
    func setUpTableView() -> Void {
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib.init(nibName:String(describing: type(of:STSearchCell())), bundle: Bundle.main), forCellReuseIdentifier: STSearchCell.cellIdentifier())
        self.tableView.estimatedRowHeight = 218
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12)

        self.tableView.mj_footer = MJDIYAutoFooter.init(refreshingBlock: {
            self.page += 1
            self.loadData(searchText: self.searchBar!.text!)
        })
    }
    
    //MARK: - 获取数据
    func loadData(searchText:String) {

        let url = get_search_result + "+" + searchText + "&pg=" + "\(self.page)"
        
        // url编码
        STClient.get(url: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), parameters: nil, to: nil) { (response: Any?,error: Error?) in
            
            self.tableView.mj_footer.endRefreshing()
            
            if !(error != nil) {
                let responseData = response as! Dictionary<String, Any>
                
                // 判断有无更多数据
                if responseData["pages"] != nil {
                    let page = STSeachPages.init(dict: responseData["pages"] as! [String : Any])
                    if !page.has_next {
                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                }
                
                if self.page == 1 {
                    self.dataSource.removeAll()
                }
                
                // 数据装载
                if responseData["results"] is NSArray{
                    let arr:NSArray = responseData["results"] as! NSArray
                    for dict:Dictionary in arr as! [Dictionary<String, Any>]{
                        // 遍历得到Model
                        let searchResult = STSearchResult.init(dict: dict)
                        self.dataSource.append(searchResult)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - TableViewDelegate & TableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:STSearchCell = tableView.dequeueReusableCell(withIdentifier: STSearchCell.cellIdentifier(), for: indexPath) as! STSearchCell
        cell.searchResult = self.dataSource[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let content = self.dataSource[indexPath.row]
//        let VC:STContentDetailViewController = UIStoryboard.init(name: "STBodyStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: STContentDetailViewController.classForCoder())) as! STContentDetailViewController
//        VC.content = content
//        VC.hidesBottomBarWhenPushed = true;
//        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar?.resignFirstResponder()
    }

    //MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.page = 1
        self.loadData(searchText: searchBar.text!)
    }
}
