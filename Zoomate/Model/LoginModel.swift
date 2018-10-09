//
//  LoginModel.swift
//  Zoomate
//
//  Created by Koshal Saini on 01/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginModel: NSObject {
    
    var commenModel = CommenModel()
    
    var id:String?
    var profileId:String?
    var email:String?
    var firstName:String?
    var lastName:String?
    var profilePic:String?
    var gender:String?
    var about:String?
    var requirment:String?
    var userType:String?
    var is_completed:String?
    
    
    var arr_UserRole = [UserRoleModel]()
    
    
    init(with LoginDetails:[String:JSON]) {
        commenModel.statuscode = LoginDetails["statuscode"]?.intValue ?? 0
        commenModel.message = LoginDetails["message"]?.stringValue ?? KSConstant().BLANK
        
        self.id  = LoginDetails["userData"]?["id"].stringValue ?? KSConstant().BLANK
        self.profileId  = LoginDetails["userData"]?["profileId"].stringValue ?? KSConstant().BLANK
        self.email  = LoginDetails["userData"]?["email"].stringValue ?? KSConstant().BLANK
        self.firstName  = LoginDetails["userData"]?["firstName"].stringValue ?? KSConstant().BLANK
        self.lastName  = LoginDetails["userData"]?["lastName"].stringValue ?? KSConstant().BLANK
        self.profilePic  = LoginDetails["userData"]?["profilePic"].stringValue ?? KSConstant().BLANK
        self.gender  = LoginDetails["userData"]?["gender"].stringValue ?? KSConstant().BLANK
        self.about  = LoginDetails["userData"]?["about"].stringValue ?? KSConstant().BLANK
        self.requirment  = LoginDetails["userData"]?["requirment"].stringValue ?? KSConstant().BLANK
        self.userType  = LoginDetails["userData"]?["userType"].stringValue ?? KSConstant().BLANK
        self.is_completed = LoginDetails["userData"]?["is_completed"].stringValue ?? KSConstant().BLANK
        
        if LoginDetails["userRole"]?.arrayValue != nil {
            let arryValueInfo = LoginDetails["userRole"]?.arrayValue
            for values in arryValueInfo! {
                let notification : UserRoleModel = UserRoleModel.init(with: values.dictionaryValue)
                arr_UserRole.append(notification)
            }
        }
    }
}

class UserRoleModel: NSObject {
    var id:String?
    var role:String?
    
    init(with UserRole:[String:JSON]) {
        self.id = UserRole["id"]?.stringValue ?? KSConstant().BLANK
        self.role = UserRole["role"]?.stringValue ?? KSConstant().BLANK
    }
}

