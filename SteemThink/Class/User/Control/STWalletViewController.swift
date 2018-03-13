//
//  STWalletViewController.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/3/13.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STWalletViewController: UITableViewController {
    
    @IBOutlet weak var steemLab: UILabel!
    @IBOutlet weak var powerLab: UILabel!
    @IBOutlet weak var dollarLab: UILabel!
    @IBOutlet weak var savingLab: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = localizedString(key: "Wallet", comment: "")
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    class func initWithStortBorad(nibName:String) -> STWalletViewController {
        let VC = UIStoryboard.init(name: nibName, bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: self.classForCoder()))
        return VC as! STWalletViewController
    }
    
    func loadData() {
        let author = [UserDataManager.sharedInstance.getUserName()]
        let jsonStr = NSArray_STExtension.getJSONStringFromArray(array:author as [AnyObject])
        let url = get_accounts  + jsonStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        STAFNetworkTools.sharedTools.request(method: .GET, urlString: url, parameters: nil) { (response, error) in
            if response is NSArray{
                for dic:Dictionary in response as! [Dictionary<String, Any>]{
                    let user:STUser = STUser.init(dict: dic)
                    self.steemLab.text = user.balance
                    self.dollarLab.text = user.sbd_balance
                    self.savingLab.text = user.savings_sbd_balance
                    break;
                }
            }
        }
    }

}
