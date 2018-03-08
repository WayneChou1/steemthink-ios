//
//  STContentDetailViewController.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/28.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit
import IQKeyboardManager

let bootomEdge:CGFloat = 45.0

class STContentDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var content:STContent?
    lazy var dataSource:[STComment] = {
        let source:[STComment] = []
        return source
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = localizedString(key: "Content", comment: "")
        self.setUpTableView()
        self.setUpInputView()
//        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
    }
    
    
    func setUpTableView() -> Void {
        self.tableView.register(UINib.init(nibName: String(describing: STContentDetailTableViewCell.classForCoder()), bundle: Bundle.main), forCellReuseIdentifier: STContentDetailTableViewCell.cellIdentifier())
        
        let contentHeaderView:STContentHeaderView = Bundle.main.loadNibNamed(String(describing: STContentHeaderView.classForCoder()), owner: self, options: nil)?.first as! STContentHeaderView
        contentHeaderView.content = self.content
        contentHeaderView.reloadFrame()
        self.tableView.tableHeaderView = contentHeaderView
        self.tableView.tableFooterView = UIView()
        let edge = self.tableView.contentInset
        self.tableView.contentInset = UIEdgeInsetsMake(edge.top, edge.left, bootomEdge, edge.right)
        self.tableView.mj_header =  MJDIYHeader.init(refreshingBlock: {
            self.loadData()
        })
        self.tableView.mj_header.beginRefreshing()
    }
    
    func setUpInputView() {
        let inputView = STCommentInputView.init(frame: CGRect.init(x: 0, y: screen_height - bootomEdge, width: screen_width, height: bootomEdge)) {[weak self] (text) in
            self?.sencComment(text: text)
        }
        self.view.addSubview(inputView)
    }
    
    func setFooterView(isShow:Bool) -> Void {
        if isShow {
            let contentFooterView:STContentNoDataFooterView = Bundle.main.loadNibNamed(String(describing: STContentNoDataFooterView.classForCoder()), owner: self, options: nil)?.first as! STContentNoDataFooterView
            contentFooterView.detailLab.text = localizedString(key: "No Comment", comment: "")
            self.tableView.tableFooterView = contentFooterView;
        }else{
            self.tableView.tableFooterView = UIView()
        }
    }
    
    func loadData() -> Void {
        let url = get_content_replies + "author=" + (content?.author)! + "&permlink=" + (content?.permlink)!
        STClient.get(url: url, parameters: nil, to: nil) { (response: Any?,error: Error?) in
            self.tableView.mj_header.endRefreshing()
            if response is NSArray{
                let dicArr:NSArray = response as! NSArray
                
                if dicArr.count == 0 {
                    // 显示占位图
                    self.setFooterView(isShow: true)
                    return;
                }
                // 不显示占位图
                self.setFooterView(isShow: false)
                
                for dic:Dictionary in dicArr as! [Dictionary<String, Any>]{
                    // 遍历得到Model
                    let comment = STComment.init(dict: dic)
                    self.dataSource.append(comment)
                }
            }
            self.tableView.reloadData()
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
        let cell:STContentDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: STContentDetailTableViewCell.cellIdentifier(), for: indexPath) as! STContentDetailTableViewCell
        cell.comment = self.dataSource[indexPath.row]
        return cell
    }
    
    //MARK: - Send Comment
    func sencComment(text:String?) {
        
        let permlink = STFormatter.commentPermlink(parentAuthor: (content?.author)!, parentPermlink: (content?.parent_permlink)!)
        print("permlink ========" + permlink!)
        
        if permlink != nil {
            STClient.comment(parentAuthor: (content?.author)!, parentPermlink: (content?.permlink)!, author: UserDataManager.sharedInstance.getUserName(), permlink: permlink!, body: text!) { (response, error) in
                self.tableView.mj_header.beginRefreshing()
            }
        }
    }
}
