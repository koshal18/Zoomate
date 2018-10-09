//
//  MessageVC.swift
//  Zoomate
//
//  Created by Developer on 16/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SDWebImage
class MessageVC: UIViewController {
    
    @IBOutlet weak var tblMessages: UITableView!
    var objModel:MessageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMessages()
    }
    
    
    func setUpMessages(){
        let param = ["userId":UserDefaults.standard.value(forKey: "user_id")!]
        MessageVM.callAllMessages(viewController:self, parameters:param as NSDictionary){ (response) in
            print("resfponse",response)
            self.objModel = response
            self.tblMessages.reloadData()
        }
    }
    
    
    @IBAction func tapLeftMenuButton(_ sender: Any) {
        panel?.openLeft(animated: true)
    }
}


extension MessageVC:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if objModel != nil {
            return (objModel?.arr_UserMessages.count)!
        }else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellMessages", for: indexPath) as! CellMessages
        cell.lblUserName.text = self.objModel?.arr_UserMessages[indexPath.row].name
        cell.imgUser.sd_setImage(with:URL(string:(self.objModel?.arr_UserMessages[indexPath.row].profilePic)!), placeholderImage:#imageLiteral(resourceName: "placeHolder"))
        if self.objModel?.arr_UserMessages[indexPath.row].available == "0" {
            cell.lblOnline.text = self.objModel?.arr_UserMessages[indexPath.row].created
            cell.width_Online.constant = 0
        }else{
            cell.lblOnline.text = "  Online"
            cell.width_Online.constant = 18
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        objVC.str_Id = (self.objModel?.arr_UserMessages[indexPath.row].chatId)!
        self.navigationController?.pushViewController(objVC, animated: true)
    }
}


class CellMessages:UITableViewCell {
    @IBOutlet weak var width_Online: NSLayoutConstraint!
    @IBOutlet weak var lblOnline: UILabel!
    @IBOutlet weak var imgOnline: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    
}
