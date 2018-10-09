//
//  UsersListModel.swift
//  Zoomate
//
//  Created by Koshal Saini on 29/08/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON

class UsersListModel: NSObject {
    
    var commenModel = CommenModel()
    var arr_UserList = [userDetails]()
    
    init(with details:[String:JSON]) {
        commenModel.statuscode = details["statuscode"]?.intValue ?? 0
        commenModel.message = details["message"]?.stringValue ?? KSConstant().BLANK
        
        if details["userdata"]?.arrayValue != nil {
            let arryValueInfo = details["userdata"]?.arrayValue
            for values in arryValueInfo! {
                let objModel : userDetails = userDetails.init(with: values.dictionaryValue)
                arr_UserList.append(objModel)
            }
        }
    }
}

class userDetails: NSObject {
    var id:String?
    var email:String?
    var firstName:String?
    var lastName:String?
    var profilePic:String?
    var about:String?
    var skill:String?
    var userType:String?
    var public_review:String?
    var total_rating:String?
    var arr_Speciality = [specialityModel]()
    
    init(with details:[String:JSON]) {
        self.id = details["id"]?.stringValue ?? KSConstant().BLANK
        self.email = details["email"]?.stringValue ?? KSConstant().BLANK
        self.firstName = details["firstName"]?.stringValue ?? KSConstant().BLANK
        self.lastName = details["lastName"]?.stringValue ?? KSConstant().BLANK
        self.profilePic = details["profilePic"]?.stringValue ?? KSConstant().BLANK
        self.about = details["about"]?.stringValue ?? KSConstant().BLANK
        self.skill = details["skill"]?.stringValue ?? KSConstant().BLANK
        self.userType = details["userType"]?.stringValue ?? KSConstant().BLANK
        self.public_review = details["rating"]?["public_review"].stringValue ?? KSConstant().BLANK
        self.total_rating = details["rating"]?[0]["total_rating"].stringValue ?? KSConstant().BLANK
        
        if details["specialties"]?.arrayValue != nil {
            let arryValueInfo = details["specialties"]?.arrayValue
            for values in arryValueInfo! {
                let objModel : specialityModel = specialityModel.init(with: values.dictionaryValue)
                arr_Speciality.append(objModel)
            }
        }
    }
}

class specialityModel: NSObject {
    
    var id:String?
    var specialties:String?
    var user_id:String?
    
    init(with details:[String:JSON]) {
        self.id = details["id"]?.stringValue ?? KSConstant().BLANK
        self.specialties = details["specialties"]?.stringValue ?? KSConstant().BLANK
        self.user_id = details["user_id"]?.stringValue ?? KSConstant().BLANK
    }
}





