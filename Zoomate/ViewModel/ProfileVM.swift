//
//  ProfileVM.swift
//  Zoomate
//
//  Created by Koshal Saini on 13/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class ProfileVM: NSObject {

    func callGetGalleryImages(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (ProfileModel) -> Void) {
        DataManager.alamofirePostRequest(url:BaseUrl+GetGalleryImagesUrl, viewcontroller:viewController, parameters:parameters as? [String : AnyObject]) { (responseObject, error) in
            print(responseObject!)
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:ProfileModel = ProfileModel.init(with: arryValueInfo!)
            if objModel.statuscode == 200 {
                completion(objModel)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.message!, view: viewController, completion: {})
            }
        }
    }
    
    func callUploadGalleryImage(viewController:UIViewController, parameters:NSDictionary,imageData: UIImage?, completion: @escaping () -> Void) {
        DataManager.alamofirePostRequestUploadMultipleImage(url: BaseUrl+UploadImageUrl, image:imageData!, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { responseObject, error, responseDict  in
            print(responseObject!)
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:ResendOTPModel = ResendOTPModel.init(with: arryValueInfo!)
            if objModel.statuscode == 200 {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.message!, view: viewController, completion: {})
                completion()
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.message!, view: viewController, completion: {})
            }
            
            print(responseObject!)
            print(error.debugDescription)
        }
    }
}
