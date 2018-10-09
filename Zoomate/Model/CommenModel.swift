//
//  CommenModel.swift
//  Zoomate
//
//  Created by Koshal Saini on 01/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommenModel: NSObject {
    var statuscode:Int?
    var message:String?
}

class ResendOTPModel: NSObject {
    
    var statuscode:Int?
    var message:String?
    
    init(with details:[String:JSON]) {
        self.statuscode = details["statuscode"]?.intValue ?? 0
        self.message  = details["message"]?.stringValue ?? KSConstant().BLANK
    }
}
