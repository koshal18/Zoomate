//
//  ProfessionalVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 07/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import KRProgressHUD

class ProfessionalVM: NSObject {

    /**
     @description: This method will be used for Submit OTP Web Service.
     @parameters:  (viewController:UIViewController, parameters:NSDictionary, completion: @escaping (SignUpModel) -> Void)
     @returns:Nil
     */
    func callSelectUserTypeWS(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (ResendOTPModel) -> Void) {
        KRProgressHUD.show(withMessage: KSConstant().PROGRESS_TITLE)
        DataManager.alamofirePostRequest(url: BaseUrl+SelectTypeURL, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            
            print(responseObject ?? KSConstant().BLANK)
            
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:ResendOTPModel = ResendOTPModel.init(with: arryValueInfo!)
            
            if objModel.statuscode == 200 {
                completion(objModel)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.message!, view: viewController, completion: {})
            }
        }
    }
}
