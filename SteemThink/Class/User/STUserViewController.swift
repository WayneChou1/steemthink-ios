//
//  STUserViewController.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/27.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STUserViewController: UITableViewController,UserNoLoginDelegate {
    
    @IBOutlet weak var questionLab: UILabel!
    @IBOutlet weak var answerLab: UILabel!
    @IBOutlet weak var replyLab: UILabel!
    @IBOutlet weak var walletLab: UILabel!
    @IBOutlet weak var logoutLab: UILabel!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpText()
        self.setUpSubView()
        self.setUpNoti()
        self.navigationItem.title = localizedString(key: "Mine", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    class func initWithStortBorad(nibName:String) -> STUserViewController {
        let VC = UIStoryboard.init(name: nibName, bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: self.classForCoder()))
        return VC as! STUserViewController
    }
    
    func setUpText() -> Void {
        questionLab.text = localizedString(key: "My Question", comment: "")
        answerLab.text = localizedString(key: "My Answer", comment: "")
        replyLab.text = localizedString(key: "Replies To Me", comment: "")
        walletLab.text = localizedString(key: "Wallet", comment: "")
        logoutLab.text = localizedString(key: "Logout", comment: "")
    }
    
    @objc func setUpSubView() {
        self.tableView.reloadData();
        if UserDataManager.sharedInstance.isLogin() {
            let headerView:STUserHeaderView = Bundle.main.loadNibNamed(String(describing: STUserHeaderView.classForCoder()), owner: self, options: nil)?.first as! STUserHeaderView
            headerView.userName = (userDefault().object(forKey: UserDataSaveConstants.st_userName_save) as! String)
            self.tableView.tableHeaderView = headerView
        }else{
            let headerView:STUserNoLoginHeaderView = Bundle.main.loadNibNamed(String(describing: STUserNoLoginHeaderView.classForCoder()), owner: self, options: nil)?.first as! STUserNoLoginHeaderView
            headerView.delegate = self
            self.tableView.tableHeaderView = headerView
        }
    }
    
    //MARK: - 接受通知
    func setUpNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(setUpSubView), name: NSNotification.Name(rawValue:UserDataLogin.st_user_data_login), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setUpSubView), name: NSNotification.Name(rawValue:UserDataLogin.st_user_data_logout), object: nil)
    }
    
    //MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if UserDataManager.sharedInstance.isLogin() {
            return super.numberOfSections(in: tableView)
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if UserDataManager.sharedInstance.isLogin() {
            if indexPath.section == 0{
                
            }
            if indexPath.section == 1{
                UserDataManager.sharedInstance.logout()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    //MARK: - UserNoLoginDelegate
    func userLogin() {
        let loginVC = STLoginViewController()
        let naVC = STNavigationViewController.init(rootViewController: loginVC)
        self.present(naVC, animated: true, completion: nil)
    }
}
