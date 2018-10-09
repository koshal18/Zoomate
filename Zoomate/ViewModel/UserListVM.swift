//
//  UserListVM.swift
//  Zoomate
//
//  Created by Koshal Saini on 28/08/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class UserListVM: NSObject {
    
    class func callGetUserListWS(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (UsersListModel) -> Void) {
        DataManager.alamofireGetRequest(url: BaseUrl+GetUserList, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            
            print(responseObject ?? "")
            let arryValueInfo = responseObject?.dictionaryValue
            
            let objModel:UsersListModel = UsersListModel.init(with: arryValueInfo!)
            if objModel.commenModel.statuscode == 200 {
                completion(objModel)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.commenModel.message!, view: viewController, completion: {})
            }
        }
    }
    
    class func callGetUserList(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (UsersListModel) -> Void) {
        DataManager.alamofirePostRequest(url: BaseUrl+GetUserList, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            print(responseObject!)
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:UsersListModel = UsersListModel.init(with: arryValueInfo!)
            if objModel.commenModel.statuscode == 200 {
                completion(objModel)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.commenModel.message!, view: viewController, completion: {})
            }
        }
    }
}


