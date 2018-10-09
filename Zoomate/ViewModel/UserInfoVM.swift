//
//  UserInfoVM.swift
//  Zoomate
//
//  Created by Developer on 27/08/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class UserInfoVM: NSObject {
    
    class func callUserInfo(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (UserInfoModel) -> Void) {
        DataManager.alamofirePostRequest(url: BaseUrl+GetuserInfo, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            print(responseObject!)
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:UserInfoModel = UserInfoModel.init(with: arryValueInfo!)
            
            if objModel.statuscode == 200 {
                completion(objModel)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.message!, view: viewController, completion: {})
            }
        }
    }
}
