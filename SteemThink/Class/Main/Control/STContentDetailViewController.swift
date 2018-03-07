//
//  STContentDetailViewController.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/28.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STContentDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var content:STContent?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableViewHeader()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpTableViewHeader() -> Void {
        let contentHeaderView:STContentHeaderView = Bundle.main.loadNibNamed(String(describing: STContentHeaderView.classForCoder()), owner: self, options: nil)?.first as! STContentHeaderView
        contentHeaderView.content = self.content
        contentHeaderView.reloadFrame()
        self.tableView.tableHeaderView = contentHeaderView
    }
}
