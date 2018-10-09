//
//  ChangePasswordModel.swift
//  Zoomate
//
//  Created by Developer on 18/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChangePasswordModel: NSObject {
    var statuscode:Int?
    var message:String?
    
    
    init(userDetails:[String:JSON]) {
        
        self.statuscode = userDetails["statuscode"]?.intValue ?? 0
        self.message  = userDetails["message"]?.stringValue ?? KSConstant().BLANK
    }
}
