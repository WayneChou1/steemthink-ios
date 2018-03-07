//
//  STUserViewController.swift
//  SteemThink
//
//  Created by zhouzhiwei on 2018/2/27.
//  Copyright © 2018年 zijinph. All rights reserved.
//

import UIKit

class STUserViewController: UITableViewController {
    
    @IBOutlet weak var questionLab: UILabel!
    @IBOutlet weak var answerLab: UILabel!
    @IBOutlet weak var replyLab: UILabel!
    @IBOutlet weak var walletLab: UILabel!
    @IBOutlet weak var logoutLab: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpText()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
