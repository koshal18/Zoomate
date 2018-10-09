
//
//  SendMessageModel.swift
//  Zoomate
//
//  Created by Developer on 07/09/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON
class SendMessageModel: NSObject {
    var statuscode:String?
    var message:String?
    var arr_ChatUserDataModel = [ChatMessageDataModel]()
    
    
    override init() {
        
    }
    
    init(with details:[String:JSON]) {
        self.statuscode = details["statuscode"]?.stringValue ?? KSConstant().BLANK
        self.message = details["message"]?.stringValue ?? KSConstant().BLANK
        
        if details["userdata"]?.arrayValue != nil {
            let arryValueInfo = details["userdata"]?.arrayValue
            for values in arryValueInfo! {
                let objData : ChatMessageDataModel = ChatMessageDataModel.init(with: values.dictionaryValue)
                arr_ChatUserDataModel.append(objData)
            }
        }
    }
}

class ChatMessageDataModel: NSObject {
    
    var profilePic:String?
    var receiverId:String?
    var senderId:String?
    var msg:String?
    var time:String?
    
    init(with details:[String:JSON]) {
        self.profilePic = details["profilePic"]?.stringValue ?? KSConstant().BLANK
        self.receiverId = details["receiverId"]?.stringValue ?? KSConstant().BLANK
        self.senderId = details["senderId"]?.stringValue ?? KSConstant().BLANK
        self.msg = details["msg"]?.stringValue ?? KSConstant().BLANK
        self.time = details["time"]?.stringValue ?? KSConstant().BLANK
    }
}
