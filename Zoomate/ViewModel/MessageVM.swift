//
//  MessageVM.swift
//  Zoomate
//
//  Created by Developer on 05/09/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class MessageVM: NSObject {

    class func callAllMessages(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (MessageModel) -> Void) {
        DataManager.alamofirePostRequest(url: BaseUrl+AddAllChatUrl, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            print(responseObject!)
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:MessageModel = MessageModel.init(userDetails: arryValueInfo!)
            if objModel.statuscode == 200 {
                completion(objModel)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.message!, view: viewController, completion: {})
            }
        }
    }
    
}
