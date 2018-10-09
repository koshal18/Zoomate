//
//  SignUpModel.swift
//  Zoomate
//
//  Created by Koshal Saini on 30/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON


class SignUpModel: NSObject {

    var statuscode:Int?
    var message:String?
    
    var id:String?
    var firstName:String?
    var lastName:String?
    var email:String?
    var username:String?
    var password:String?
    var gender:String?
    var about:String?
    var requirment:String?
    var availability:String?
    var mobile:String?
    var price:String?
    var skill:String?
    var otp:String?
    var city:String?
    var state:String?
    var height:String?
    var weight:String?
    var ethnicity:String?
    var social_id:String?
    var device_type:String?
    var device_token:String?
    var latitude:String?
    var longitude:String?
    var profile_pic:String?
    var is_active:String?
    var user_type:String?
    var referal_code:String?
    var created:String?
    var updated:String?
    var devared:String?
    
    init(userDetails:[String:JSON]) {
        
        self.statuscode = userDetails["statuscode"]?.intValue ?? 0
        self.message  = userDetails["message"]?.stringValue ?? KSConstant().BLANK
            
        self.id  = userDetails["userData"]?["id"].stringValue ?? KSConstant().BLANK
        self.firstName = userDetails["userData"]?["firstName"].stringValue ?? KSConstant().BLANK
        self.lastName = userDetails["userData"]?["lastName"].stringValue ?? KSConstant().BLANK
        self.email = userDetails["userData"]?["email"].stringValue ?? KSConstant().BLANK
        self.username = userDetails["userData"]?["username"].stringValue ?? KSConstant().BLANK
        self.password = userDetails["userData"]?["password"].stringValue ?? KSConstant().BLANK
        self.gender = userDetails["userData"]?["gender"].stringValue ?? KSConstant().BLANK
        self.about = userDetails["userData"]?["about"].stringValue ?? KSConstant().BLANK
        self.requirment = userDetails["userData"]?["requirment"].stringValue ?? KSConstant().BLANK
        self.availability = userDetails["userData"]?["availability"].stringValue ?? KSConstant().BLANK
        self.mobile = userDetails["userData"]?["mobile"].stringValue ?? KSConstant().BLANK
        self.price = userDetails["userData"]?["price"].stringValue ?? KSConstant().BLANK
        self.skill = userDetails["userData"]?["skill"].stringValue ?? KSConstant().BLANK
        self.otp = userDetails["userData"]?["otp"].stringValue ?? KSConstant().BLANK
        self.city = userDetails["userData"]?["city"].stringValue ?? KSConstant().BLANK
        self.state = userDetails["userData"]?["state"].stringValue ?? KSConstant().BLANK
        self.height = userDetails["userData"]?["height"].stringValue ?? KSConstant().BLANK
        self.weight = userDetails["userData"]?["weight"].stringValue ?? KSConstant().BLANK
        self.ethnicity = userDetails["userData"]?["ethnicity"].stringValue ?? KSConstant().BLANK
        self.social_id = userDetails["userData"]?["social_id"].stringValue ?? KSConstant().BLANK
        self.device_type = userDetails["userData"]?["device_type"].stringValue ?? KSConstant().BLANK
        self.device_token = userDetails["userData"]?["device_token"].stringValue ?? KSConstant().BLANK
        self.latitude = userDetails["userData"]?["latitude"].stringValue ?? KSConstant().BLANK
        self.longitude = userDetails["userData"]?["longitude"].stringValue ?? KSConstant().BLANK
        self.profile_pic = userDetails["userData"]?["profile_pic"].stringValue ?? KSConstant().BLANK
        self.is_active = userDetails["userData"]?["is_active"].stringValue ?? KSConstant().BLANK
        self.user_type = userDetails["userData"]?["user_type"].stringValue ?? KSConstant().BLANK
        self.referal_code = userDetails["userData"]?["referal_code"].stringValue ?? KSConstant().BLANK
        self.created = userDetails["userData"]?["created"].stringValue ?? KSConstant().BLANK
        self.updated = userDetails["userData"]?["updated"].stringValue ?? KSConstant().BLANK
        self.devared = userDetails["userData"]?["devared"].stringValue ?? KSConstant().BLANK
    }
}



