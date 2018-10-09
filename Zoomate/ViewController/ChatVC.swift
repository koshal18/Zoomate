

//
//  ChatVC.swift
//  Zoomate
//
//  Created by Developer on 17/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    var arr_ChatData = ChatModel()
    var str_Id = String()

    @IBOutlet weak var txt_Message: UITextField!
    @IBOutlet weak var tblChar: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.callGetAllChatsWS()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: -
    // MARK: - UIButton Action
    @IBAction func tapSendMessageButton(_ sender: Any) {
        if (self.txt_Message.text?.count)! > 0 {
            self.callSendMessageWS()
        }
    }
    
    @IBAction func btnMethodBack(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
    // MARK: -
    // MARK: - Call Web Service
    //*****------------------------------***** !! Get All Chats !! *****------------------------------*****//
    func callGetAllChatsWS() {
        let param = ["recvId":self.str_Id,
                     "sendId":UserDefaults.standard.value(forKey: "user_id")]
        ChatVM.callAllChatMessages(viewController: self, parameters: param as NSDictionary) { responseObject in
            self.arr_ChatData = responseObject
            self.tblChar.reloadData()
            self.scrollToBottom()
        }
    }
    
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.arr_ChatData.arr_ChatUserDataModel.count-1, section: 0)
            self.tblChar.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
  
    //*****------------------------------***** !! Get All Chats !! *****------------------------------*****//
    func callSendMessageWS() {
        
        let param = ["recvId":self.str_Id,
                     "sendId":UserDefaults.standard.value(forKey: "user_id"),
                     "msg":self.txt_Message.text!]
        
        ChatVM.callSendMessagesWS(viewController: self, parameters: param as NSDictionary) { responseObject in
            self.arr_ChatData = responseObject
            self.txt_Message.text = ""
            self.tblChar.reloadData()
             self.scrollToBottom()
        }
    }
}


extension ChatVC:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arr_ChatData.arr_ChatUserDataModel.count > 0 {
            return self.arr_ChatData.arr_ChatUserDataModel.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.arr_ChatData.arr_ChatUserDataModel[indexPath.row].senderId! == UserDefaults.standard.value(forKey: "user_id")! as? String ?? "" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatSecondUser", for: indexPath) as! ChatSecondUser
            cell.selectionStyle = .none
            cell.lbl_Message.text = self.arr_ChatData.arr_ChatUserDataModel[indexPath.row].msg
            cell.lbl_ProfilePic.sd_setImage(with: URL(string: self.arr_ChatData.arr_ChatUserDataModel[indexPath.row].profilePic!), placeholderImage: #imageLiteral(resourceName: "placeHolder"))
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatFirstUser", for: indexPath) as! ChatFirstUser
            cell.selectionStyle = .none
            cell.lbl_Message.text = self.arr_ChatData.arr_ChatUserDataModel[indexPath.row].msg
            cell.lbl_ProfilePic.sd_setImage(with: URL(string: self.arr_ChatData.arr_ChatUserDataModel[indexPath.row].profilePic!), placeholderImage: #imageLiteral(resourceName: "placeHolder"))
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
}



class ChatFirstUser: UITableViewCell {
    @IBOutlet weak var lbl_Message: UILabel!
    @IBOutlet weak var lbl_ProfilePic: UIImageView!
}


class ChatSecondUser: UITableViewCell {
    @IBOutlet weak var lbl_Message: UILabel!
    @IBOutlet weak var lbl_ProfilePic: UIImageView!
}
