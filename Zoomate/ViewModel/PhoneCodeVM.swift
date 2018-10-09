//
//  PhoneCodeVM.swift
//  Zoomate
//
//  Created by Koshal Saini on 30/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import KRProgressHUD

class PhoneCodeVM: NSObject {
    
    /**
     @description: This method will be used for Submit OTP Web Service.
     @parameters:  (viewController:UIViewController, parameters:NSDictionary, completion: @escaping (SignUpModel) -> Void)
     @returns:Nil
     */
    func callPhoneCodeWS(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (SignUpModel) -> Void) {
        KRProgressHUD.show(withMessage: KSConstant().PROGRESS_TITLE)
        DataManager.alamofirePostRequest(url: BaseUrl+VerifyAccountUrl, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            
            print(responseObject ?? KSConstant().BLANK)
            
            let arryValueInfo = responseObject?.dictionaryValue
            let objSignUp:SignUpModel = SignUpModel.init(userDetails: arryValueInfo!)
            
            if objSignUp.statuscode == 200 {
                completion(objSignUp)
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objSignUp.message!, view: viewController, completion: {})
            }
        }
    }
    
    /**
     @description: This method will be used for Resend OTP Web Service.
     @parameters:  (viewController:UIViewController, parameters:NSDictionary, completion: @escaping (SignUpModel) -> Void)
     @returns:Nil
     */
    func callResendOTPWS(viewController:UIViewController, parameters:NSDictionary, completion: @escaping () -> Void) {
        KRProgressHUD.show(withMessage: KSConstant().PROGRESS_TITLE)
        DataManager.alamofirePostRequest(url: BaseUrl+ResendOTPURL, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
            
            print(responseObject ?? KSConstant().BLANK)
            
            let arryValueInfo = responseObject?.dictionaryValue
            let objModel:ResendOTPModel = ResendOTPModel.init(with: arryValueInfo!)
            
            if objModel.statuscode == 200 {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.message!, view: viewController, completion: {})
                completion()
            }else {
                CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.message!, view: viewController, completion: {})
            }
        }
    }
    
    /**
     @description: This method will be used for Validate OTP.
     @parameters:  (viewController:UIViewController, parameters:NSDictionary, completion: @escaping (SignUpModel) -> Void)
     @returns:Nil
     */
    func validateTextField(otp:UITextField, userID:String, viewController:UIViewController, completion: @escaping () -> Void) {
        if (otp.text?.count)! > 0 && userID.count > 0 {
            
            let param = ["otp":otp.text!,
                         "userId":userID]
            
            self.callPhoneCodeWS(viewController: viewController, parameters: param as NSDictionary) {_ in
                completion()
            }
        }
        else if (otp.text?.count)! <= 0 {
            CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: KSConstant().MSG_OTP, view: viewController) {}
        }
    }
}
