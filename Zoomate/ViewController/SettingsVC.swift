//
//  SettingsVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 03/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsVC: UIViewController {
    
    //    var arr_Settings = ["System settings", "Preference settings", "Notification settings", "And more...", "Change Password"]
    var arr_Settings = ["Notification settings", "Change Password"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: -
    // MARK: - UIButton Action
    @IBAction func tapBackButton(_ sender: Any) {
        panel?.openLeft(animated: true)
    }
    
}

extension SettingsVC:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_Settings.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        cell.selectionStyle = .none
        cell.lbl_Settings.text = self.arr_Settings[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 0 {
            // navigateVCWith(identifier: "ProfileVC")
            let settings = UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        else {
            let objVC = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
            self.navigationController?.pushViewController(objVC, animated: true)
        }
    }
}


class SettingsCell: UITableViewCell {
    @IBOutlet weak var lbl_Settings: UILabel!
}
