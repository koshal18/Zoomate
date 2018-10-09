//
//  HiringModel.swift
//  Zoomate
//
//  Created by Koshal Saini on 07/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON

class HiringModel: NSObject {
    var commenModel = CommenModel()
    var objSkills = [HiringSkillsModel]()
    
    init(with details:[String:JSON]) {
        commenModel.statuscode = details["statuscode"]?.intValue ?? 0
        commenModel.message = details["message"]?.stringValue ?? KSConstant().BLANK
        
        if details["skill"]?.arrayValue != nil {
            let arryValueInfo = details["skill"]?.arrayValue
            for values in arryValueInfo! {
                let objModel : HiringSkillsModel = HiringSkillsModel.init(with: values.dictionaryValue)
                objSkills.append(objModel)
            }
        }
    }
}


class HiringSkillsModel: NSObject {
    var id:String?
    var skill:String?
    
    init(with userSkills:[String:JSON]) {
        self.id = userSkills["id"]?.stringValue ?? KSConstant().BLANK
        self.skill = userSkills["skill"]?.stringValue ?? KSConstant().BLANK
    }
}
