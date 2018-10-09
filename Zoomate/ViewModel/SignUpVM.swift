//
//  SignUpVM.swift
//  Zoomate
//
//  Created by Koshal Saini on 29/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class SignUpVM: NSObject {
    
    /**
     @description: This method will be used for call SignUp Web Service.
     @parameters:  (viewController:UIViewController, parameters:NSDictionary, completion: @escaping (SignUpModel) -> Void)
     @returns:Nil
     */
    func callSignUpWS(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (SignUpModel) -> Void) {
        DataManager.alamofirePostRequest(url: BaseUrl+SignUpUrl, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { (responseObject, error) in
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
     @description: This method will be used for Validate TextFields.
     @parameters:  (email:UITextField, password:UITextField, phoneCode:UITextField, phoneNumber:UITextField, viewController:UIViewController, completion: @escaping (SignUpModel) -> Void)
     @returns:Nil
     */
    func validateTextField(email:UITextField, password:UITextField, phoneCode:UITextField, phoneNumber:UITextField, viewController:UIViewController, completion: @escaping (SignUpModel) -> Void) {
        
        if (phoneNumber.text?.count)! > 0 && (phoneCode.text?.count)! > 0 && (email.text?.count)! <= 0 && (password.text?.count)! >= 0{
            let param = ["email":"",
                         "password":"1234567",
                         "mobile":phoneCode.text! + phoneNumber.text!,
                         "deviceType":"ios",
                         "deviceToken":UserDefaults.standard.value(forKey: "deviceToken")]
            print(param)
            self.callSignUpWS(viewController: viewController, parameters: param as NSDictionary) {responseObject in
                completion(responseObject)
            }
        }
        else if (phoneNumber.text?.count)! <= 0 && (phoneCode.text?.count)! <= 0 && (email.text?.count)! > 0 {
            let param = ["email":email.text!,
                         "password":password.text!,
                         "mobile":"",
                         "deviceType":"ios",
                         "deviceToken":UserDefaults.standard.value(forKey: "deviceToken")]
            print(param)
            self.callSignUpWS(viewController: viewController, parameters: param as NSDictionary) {responseObject in
                completion(responseObject)
            }
        } else if (phoneNumber.text?.count)! <= 0 && (phoneCode.text?.count)! <= 0 && (email.text?.count)! <= 0  {
            CommenMethod.showKSAlertMessage(title: "Zoomate", message: "You can signup with Email or Phone Number", view: viewController, completion: {})
        }else if (phoneNumber.text?.count)! <= 0 && (phoneCode.text?.count)! <= 0 {
            CommenMethod.showKSAlertMessage(title: "Zoomate", message: "Please enter validate Phone number.", view: viewController, completion: {})
        }else if (email.text?.count)! > 0 && (phoneNumber.text?.count)! > 0 && (password.text?.count)! <= 0 {
           
             if !CommenMethod.isValidEmail(email:email.text! as String){
                CommenMethod.showKSAlertMessage(title: "Zoomate", message: "Please enter validate email.", view: viewController, completion: {})
            }
            CommenMethod.showKSAlertMessage(title: "Zoomate", message: "Please enter password.", view: viewController, completion: {})
        }else if (email.text?.count)! > 0 && (phoneNumber.text?.count)! > 0 && (password.text?.count)! >= 0 {
            CommenMethod.showKSAlertMessage(title: "Zoomate", message: "Please enter an Email address OR Phone number.", view: viewController, completion: {})
        }
        else if (phoneNumber.text?.count)! >= 0 && (password.text?.count)! <= 0 && (email.text?.count)! <= 0{
            CommenMethod.showKSAlertMessage(title: "Zoomate", message: "Please enter password.", view: viewController, completion: {})
        }
        else{
            //CommenMethod.showKSAlertMessage(title: "Zoomate", message: "You can signup with Email or Phone Number.", view: viewController, completion: {})
        }
    }
}

