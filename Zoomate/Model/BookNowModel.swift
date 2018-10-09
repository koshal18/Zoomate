//
//  BookNowModel.swift
//  Zoomate
//
//  Created by Developer on 07/09/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SwiftyJSON
class BookNowModel: NSObject {
  
    var statuscode:String?
    var message:String?
    
    init(with details:[String:JSON]) {
        self.statuscode = details["statuscode"]?.stringValue ?? KSConstant().BLANK
        self.message = details["message"]?.stringValue ?? KSConstant().BLANK
    }
}
