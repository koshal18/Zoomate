//
//  ExperienceLevelModel.swift
//  Zoomate
//
//  Created by Koshal Saini on 07/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON

class ExperienceLevelModel: NSObject {
    
    var commenModel = CommenModel()
    var objSpecialty = [SpecialtiesModel]()
    
    init(with details:[String:JSON]) {
        commenModel.statuscode = details["statuscode"]?.intValue ?? 0
        commenModel.message = details["message"]?.stringValue ?? KSConstant().BLANK
        
        if details["specialties"]?.arrayValue != nil {
            let arryValueInfo = details["specialties"]?.arrayValue
            for values in arryValueInfo! {
                let objModel : SpecialtiesModel = SpecialtiesModel.init(with: values.dictionaryValue)
                objSpecialty.append(objModel)
            }
        }
    }
}

class SpecialtiesModel: NSObject {
    var id:String?
    var specialty:String?
    
    init(with details:[String:JSON]) {
        self.id = details["id"]?.stringValue ?? KSConstant().BLANK
        self.specialty = details["specialty"]?.stringValue ?? KSConstant().BLANK
    }
}
