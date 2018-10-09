//
//  ForgotPasswordVM.swift
//  Zoomate
//
//  Created by Developer on 18/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class ForgotPasswordVM: NSObject {
    func callForgotPassword(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (ChangePasswordModel) -> Void) {
        
        DataManager.alamofirePostRequest(url:BaseUrl+GetforgotPassword, viewcontroller:viewController, parameters:parameters as? [String : AnyObject]) { (responseObject, error) in
            
            print(responseObject!)
            print(responseObject!["userdata"])
            
            let arryValueInfo = responseObject?.dictionaryValue
            
            let objModel:ChangePasswordModel = ChangePasswordModel.init(userDetails: arryValueInfo!)
            if objModel.statuscode == 200 {
                completion(objModel)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.message!, view: viewController, completion: {})
            }
        }
    }
}
