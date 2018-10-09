//
//  MessageModel.swift
//  Zoomate
//
//  Created by Developer on 05/09/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON
class MessageModel: NSObject {
    
    var statuscode:Int?
    var message:String?
    var name:String?
    var profilePic:String?
    var chatId:String?
    var msg:String?
    var created:String?
    var arr_UserMessages = [UserMessageModel]()
    
    init(userDetails:[String:JSON]) {
        
        self.statuscode = userDetails["statuscode"]?.intValue ?? 0
        self.message  = userDetails["message"]?.stringValue ?? KSConstant().BLANK
        
        if userDetails["userdata"]?.arrayValue != nil {
            let arryValueInfo = userDetails["userdata"]?.arrayValue
            for values in arryValueInfo! {
                let notification : UserMessageModel = UserMessageModel.init(with: values.dictionaryValue)
                arr_UserMessages.append(notification)
            }
        }
    }
}


class UserMessageModel: NSObject {
    var name:String?
    var profilePic:String?
    var chatId:String?
    var msg:String?
    var created:String?
    var available:String?
    
    init(with userDetails:[String:JSON]) {
        self.name  = userDetails["name"]?.stringValue ?? KSConstant().BLANK
        self.profilePic  = userDetails["profilePic"]?.stringValue ?? KSConstant().BLANK
        self.chatId  = userDetails["senderId"]?.stringValue ?? KSConstant().BLANK
        self.msg  = userDetails["msg"]?.stringValue ?? KSConstant().BLANK
        self.created  = userDetails["created"]?.stringValue ?? KSConstant().BLANK
        self.available  = userDetails["available"]?.stringValue ?? KSConstant().BLANK
        // available
    }
}
