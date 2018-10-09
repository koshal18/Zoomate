
//
//  ProjectVM.swift
//  Zoomate
//
//  Created by Developer on 12/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class ProjectVM: NSObject {
    
    func callAddExperienceSkillsWS(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (SpecialitiesModel) -> Void) {
        DataManager.alamofirePostRequest(url:BaseUrl+SelectProfessionalSpecialtiesUrl, viewcontroller:viewController, parameters:parameters as? [String : AnyObject]) { (responseObject, error) in
            print(responseObject!)
            print(responseObject!["userdata"])
            
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:SpecialitiesModel = SpecialitiesModel.init(with: arryValueInfo!)
            if objModel.statuscode == 200 {
                completion(objModel)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.message!, view: viewController, completion: {})
            }
        }
    }
}
