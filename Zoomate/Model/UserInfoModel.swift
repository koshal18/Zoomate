//
//  UserInfoModel.swift
//  Zoomate
//
//  Created by Developer on 27/08/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON
class UserInfoModel: NSObject {

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
    var age:String?
    var website:String?
    var page:String?
    
    var objSpecialty = [SpecialtyModel]()
    var objRole = [RolesModel]()
    var objMedia = [MediaModel]()
    var objReview = [ReviewModel]()
    
    init(with details:[String:JSON]) {
        self.statuscode = details["statuscode"]?.intValue ?? 0
        self.state = details["userdata"]?["state"].stringValue ?? KSConstant().BLANK
        self.bust = details["userdata"]?["bust/waist/hip"].stringValue ?? KSConstant().BLANK
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
       
        self.message = details["message"]?.stringValue ?? KSConstant().BLANK
        self.phone_num = details["userdata"]?["phone_num"].stringValue ?? KSConstant().BLANK
        self.price = details["userdata"]?["price"].stringValue ?? KSConstant().BLANK
        self.age = details["userdata"]?["age"].stringValue ?? KSConstant().BLANK
        
        self.website = details["userdata"]?["website"].stringValue ?? KSConstant().BLANK
        self.page = details["userdata"]?["page"].stringValue ?? KSConstant().BLANK
        
        // age
        if details["userdata"]?["Sprcialties"].arrayValue != nil {
            let arryValueInfo = details["userdata"]?["Sprcialties"].arrayValue
            for values in arryValueInfo! {
                let objModel : SpecialtyModel = SpecialtyModel.init(with: values.dictionaryValue)
                objSpecialty.append(objModel)
            }
        }
        
        if details["userdata"]?["Media"].arrayValue != nil {
            let arryValueInfo = details["userdata"]?["Media"].arrayValue
            for values in arryValueInfo! {
                let objModel : MediaModel = MediaModel.init(with: values.dictionaryValue)
              objMedia.append(objModel)
            }
        }
        
        if details["userdata"]?["Review"].arrayValue != nil {
            let arryValueInfo = details["userdata"]?["Review"].arrayValue
            for values in arryValueInfo! {
                let objModel : ReviewModel = ReviewModel.init(with: values.dictionaryValue)
                objReview.append(objModel)
            }
        }
        
    }
}


class SpecialtyModel: NSObject {
    var specialtiesId:String?
    var specialties:String?
    
    init(with details:[String:JSON]) {
        self.specialtiesId = details["specialtiesId"]?.stringValue ?? KSConstant().BLANK
        self.specialties = details["specialties"]?.stringValue ?? KSConstant().BLANK
    }
}


class RolesModel: NSObject {
    var roleId:String?
    var role:String?
    
    init(with details:[String:JSON]) {
        self.roleId = details["roleId"]?.stringValue ?? KSConstant().BLANK
        self.role = details["role"]?.stringValue ?? KSConstant().BLANK
    }
}


class MediaModel: NSObject {
    var id:String?
    var user_id:String?
    var media:String?
    
    init(with details:[String:JSON]) {
        self.id = details["id"]?.stringValue ?? KSConstant().BLANK
        self.user_id = details["user_id"]?.stringValue ?? KSConstant().BLANK
         self.media = details["media"]?.stringValue ?? KSConstant().BLANK
    }
}

class ReviewModel: NSObject {
    var id:String?
    var to_id:String?
    var from_id:String?
    var public_review:String?
    var private_review:String?
    var deleted:String?
    var rating:String?
    
    init(with details:[String:JSON]) {
        self.id = details["id"]?.stringValue ?? KSConstant().BLANK
        self.to_id = details["to_id"]?.stringValue ?? KSConstant().BLANK
        self.from_id = details["from_id"]?.stringValue ?? KSConstant().BLANK
        self.public_review = details["public_review"]?.stringValue ?? KSConstant().BLANK
        self.private_review = details["private_review"]?.stringValue ?? KSConstant().BLANK
        self.deleted = details["deleted"]?.stringValue ?? KSConstant().BLANK
        self.rating = details["rating"]?.stringValue ?? KSConstant().BLANK
    }
}



