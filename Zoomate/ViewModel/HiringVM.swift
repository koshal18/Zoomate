//
//  HiringVM.swift
//  Zoomate
//
//  Created by Koshal Saini on 07/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import KRProgressHUD

class HiringVM: NSObject {
    /**
     @description: This method will be used for Submit OTP Web Service.
     @parameters:  (viewController:UIViewController, parameters:NSDictionary, completion: @escaping (SignUpModel) -> Void)
     @returns:Nil
     */
    func callSelectUserProfessionalWS(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (HiringModel) -> Void) {
        KRProgressHUD.show(withMessage: KSConstant().PROGRESS_TITLE)
        DataManager.alamofirePostRequest(url: BaseUrl+SelectProfessionalRoleURL, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            
            print(responseObject ?? KSConstant().BLANK)
            
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:HiringModel = HiringModel.init(with: arryValueInfo!)
            
            if objModel.commenModel.statuscode == 200 {
                completion(objModel)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.commenModel.message!, view: viewController, completion: {})
            }
        }
    }
}
