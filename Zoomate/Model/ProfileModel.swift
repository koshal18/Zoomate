//
//  ProfileModel.swift
//  Zoomate
//
//  Created by Koshal Saini on 13/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileModel: NSObject {
    var statuscode:Int?
    var message:String?
    var objImages = [ProfileImages]()
    
    init(with details:[String:JSON]) {
        self.statuscode = details["statuscode"]?.intValue ?? 0
        self.message  = details["message"]?.stringValue ?? KSConstant().BLANK
        
        if details["image"]?.arrayValue != nil {
            let arryValueInfo = details["image"]?.arrayValue
            for values in arryValueInfo! {
                let objModel : ProfileImages = ProfileImages.init(with: values.dictionaryValue)
                objImages.append(objModel)
            }
        }
    }
}

class ProfileImages: NSObject {
    var id:String?
    var image:String?
    var user_id:String?
    
    init(with details:[String:JSON]) {
        self.id = details["id"]?.stringValue ?? KSConstant().BLANK
        self.image = details["image"]?.stringValue ?? KSConstant().BLANK
        self.user_id = details["image"]?.stringValue ?? KSConstant().BLANK
    }
}
