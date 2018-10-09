//
//  ExperienceLevelVM.swift
//  Zoomate
//
//  Created by Koshal Saini on 07/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import KRProgressHUD

class ExperienceLevelVM: NSObject {
    
    func callSelectUserExperienceWS(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (ExperienceLevelModel) -> Void) {
        KRProgressHUD.show(withMessage: KSConstant().PROGRESS_TITLE)
        DataManager.alamofirePostRequest(url: BaseUrl+SelectProfessionalSkillURL, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            
            print(responseObject ?? KSConstant().BLANK)
            
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:ExperienceLevelModel = ExperienceLevelModel.init(with: arryValueInfo!)
            
            if objModel.commenModel.statuscode == 200 {
                completion(objModel)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.commenModel.message!, view: viewController, completion: {})
            }
        }
    }
    
}
