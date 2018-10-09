//
//  EditProfileModel.swift
//  Zoomate
//
//  Created by Developer on 12/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON

class EditProfileModel: NSObject {
    var state:String?
    var bust:String?
    var city:String?
    var email:String?
    var skill:String?
    var profilePic:String?
    var lastName:String?
    var gender:String?
    var ethnicity:String?
    var userType:String?
    var height:String?
    var id:String?
    var requirment:String?
    var about:String?
    var weight:String?
    var firstName:String?
    var statuscode:Int?
    var message:String?
    var phone_num:String?
    var price:String?
    var website:String?
    var page:String?
    
    var objSpecialt = [SpecialtiModel]()
    var objRol = [RolModel]()
    
    
    init(with details:[String:JSON]) {
        
        self.state = details["userdata"]?["state"].stringValue ?? KSConstant().BLANK
        self.bust = details["userdata"]?["bust"].stringValue ?? KSConstant().BLANK
        self.city = details["userdata"]?["city"].stringValue ?? KSConstant().BLANK
        self.email = details["userdata"]?["email"].stringValue ?? KSConstant().BLANK
        self.skill = details["userdata"]?["skill"].stringValue ?? KSConstant().BLANK
        self.profilePic = details["userdata"]?["profilePic"].stringValue ?? KSConstant().BLANK
        self.lastName = details["userdata"]?["lastName"].stringValue ?? KSConstant().BLANK
        self.gender = details["userdata"]?["gender"].stringValue ?? KSConstant().BLANK
        self.ethnicity = details["userdata"]?["ethnicity"].stringValue ?? KSConstant().BLANK
        self.userType = details["userdata"]?["userType"].stringValue ?? KSConstant().BLANK
        self.height = details["userdata"]?["height"].stringValue ?? KSConstant().BLANK
        self.id = details["userdata"]?["id"].stringValue ?? KSConstant().BLANK
        self.requirment = details["userdata"]?["requirment"].stringValue ?? KSConstant().BLANK
        self.about = details["userdata"]?["about"].stringValue ?? KSConstant().BLANK
        self.weight = details["userdata"]?["weight"].stringValue ?? KSConstant().BLANK
        self.firstName = details["userdata"]?["firstName"].stringValue ?? KSConstant().BLANK
        self.statuscode = details["statuscode"]?.intValue ?? 0
        self.message = details["userdata"]?["message"].stringValue ?? KSConstant().BLANK
        self.phone_num = details["userdata"]?["phone_num"].stringValue ?? KSConstant().BLANK
        self.price = details["userdata"]?["price"].stringValue ?? KSConstant().BLANK
        self.website = details["userdata"]?["website"].stringValue ?? KSConstant().BLANK
        self.page = details["userdata"]?["page"].stringValue ?? KSConstant().BLANK
        
        if details["userdata"]?["Sprcialties"].arrayValue != nil {
            
            let arryValueInfo = details["userdata"]?["Sprcialties"].arrayValue
            for values in arryValueInfo! {
                let objModel : SpecialtiModel = SpecialtiModel.init(with: values.dictionaryValue)
                objSpecialt.append(objModel)
            }
        }
        
        if details["userdata"]?["Role"].arrayValue != nil {
            let arryValueInfo = details["userdata"]?["Role"].arrayValue
            for values in arryValueInfo! {
                let objModel : RolModel = RolModel.init(with: values.dictionaryValue)
                objRol.append(objModel)
            }
        }
        
    }
}


class SpecialtiModel: NSObject {
    var specialtiesId:String?
    var specialties:String?
    
    init(with details:[String:JSON]) {
        self.specialtiesId = details["specialtiesId"]?.stringValue ?? KSConstant().BLANK
        self.specialties = details["specialties"]?.stringValue ?? KSConstant().BLANK
    }
}


class RolModel: NSObject {
    var roleId:String?
    var role:String?
    
    init(with details:[String:JSON]) {
        self.roleId = details["roleId"]?.stringValue ?? KSConstant().BLANK
        self.role = details["role"]?.stringValue ?? KSConstant().BLANK
    }
}


