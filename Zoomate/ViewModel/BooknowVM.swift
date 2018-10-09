//
//  BooknowVM.swift
//  Zoomate
//
//  Created by Developer on 07/09/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class BooknowVM: NSObject {
    class func callBookNow(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (BookNowModel) -> Void) {
        DataManager.alamofirePostRequest(url: BaseUrl+BookNow, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            print(responseObject!)
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:BookNowModel = BookNowModel.init(with: arryValueInfo!)
            if objModel.statuscode == "200" {
                completion(objModel)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.message!, view: viewController, completion: {})
            }
        }
    }
}
