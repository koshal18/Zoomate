//
//  GPIWSessionManager.swift
//  GirasolPayments_iWallet
//
//  Created by Koshal Saini on 12/03/18.
//  Copyright © 2018 GirasolPayments. All rights reserved.
//

import UIKit

class KSSessionManager {
    
    //*****Object of GPIWSessionManager*****//
    static let sharedInstance = KSSessionManager()
    private init() {}
    
    //***** APNS Notification *****//
    var deviceToken:String?
    
    var str_ProfileType:String?
    var isProfile:Bool?
    var dict_Professional = NSMutableArray()
    
    var str_ReviewID = KSConstant().BLANK
    var str_ReviewSkill = KSConstant().BLANK
    
    var lat = ""
    var lang = ""
}

