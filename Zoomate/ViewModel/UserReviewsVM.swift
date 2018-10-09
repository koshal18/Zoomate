//
//  UserReviewsVM.swift
//  Zoomate
//
//  Created by Koshal Saini on 08/09/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class UserReviewsVM: NSObject {
    class func callGetUserReviewsListWS(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (UserReviewsModel) -> Void) {
        DataManager.alamofirePostRequest(url: BaseUrl+UserReviewInfoUrl, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            print(responseObject!)
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:UserReviewsModel = UserReviewsModel.init(with: arryValueInfo!)
            if objModel.statuscode == "200" {
                completion(objModel)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: "No Data Found", view: viewController, completion: {})
            }
        }
    }
}
