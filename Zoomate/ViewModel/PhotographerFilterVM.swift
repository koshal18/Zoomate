//
//  PhotographerFilterVM.swift
//  Zoomate
//
//  Created by Koshal Saini on 29/08/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class PhotographerFilterVM: NSObject {
    class func callAddUserReviews(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (ResendOTPModel) -> Void) {
        DataManager.alamofirePostRequest(url: BaseUrl+AddReviewsUrl, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            print(responseObject!)
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
