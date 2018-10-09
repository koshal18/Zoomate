//
//  UserReviewsModel.swift
//  Zoomate
//
//  Created by Koshal Saini on 08/09/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserReviewsModel: NSObject {
    
    var statuscode:String?
    var message:String?
    var arr_UserReviewList = [UserReviewsListModel]()
    
    override init() {
    }
    
    init(with details:[String:JSON]) {
        self.statuscode = details["statuscode"]?.stringValue ?? KSConstant().BLANK
        self.message = details["message"]?.stringValue ?? KSConstant().BLANK
        
        if details["userdata"]?.arrayValue != nil {
            let arryValueInfo = details["userdata"]?.arrayValue
            for values in arryValueInfo! {
                let objData : UserReviewsListModel = UserReviewsListModel.init(with: values.dictionaryValue)
                arr_UserReviewList.append(objData)
            }
        }
    }
}


class UserReviewsListModel: NSObject {
    var name:String?
    var role:String?
    var id:String?
    var to_id:String?
    var from_id:String?
    var public_review:String?
    var recommended:String?
    var private_review:String?
    var rating:String?
    var deleted:String?
    
    init(with details:[String:JSON]) {
        self.name = details["statuscode"]?.stringValue ?? KSConstant().BLANK
        self.role = details["message"]?.stringValue ?? KSConstant().BLANK
        self.id = details["message"]?.stringValue ?? KSConstant().BLANK
        self.to_id = details["message"]?.stringValue ?? KSConstant().BLANK
        self.from_id = details["message"]?.stringValue ?? KSConstant().BLANK
        self.public_review = details["message"]?.stringValue ?? KSConstant().BLANK
        self.recommended = details["message"]?.stringValue ?? KSConstant().BLANK
        self.private_review = details["message"]?.stringValue ?? KSConstant().BLANK
        self.rating = details["message"]?.stringValue ?? KSConstant().BLANK
        self.deleted = details["message"]?.stringValue ?? KSConstant().BLANK
    }

}




