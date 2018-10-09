//
//  ChatVM.swift
//  Zoomate
//
//  Created by Koshal Saini on 06/09/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class ChatVM: NSObject {
    
    class func callAllChatMessages(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (ChatModel) -> Void) {
        DataManager.alamofirePostRequest(url: BaseUrl+InboxChatUrl, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            print(responseObject!)
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:ChatModel = ChatModel.init(with: arryValueInfo!)
            if objModel.statuscode == "200" {
                completion(objModel)
            }else {
            }
        }
    }
    
    class func callSendMessagesWS(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (ChatModel) -> Void) {
        DataManager.alamofirePostRequestWithOutLoader(url: BaseUrl+SendMessageUrl, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            print(responseObject!)
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:ChatModel = ChatModel.init(with: arryValueInfo!)
            if objModel.statuscode == "200" {
                completion(objModel)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.message!, view: viewController, completion: {})
            }
        }
    }
    
}
