//
//  DataManager.swift
//  Zoomate
//
//  Created by Koshal Saini on 29/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class DataManager: NSObject {
    /**
     @discussion:    function to call the service for JSON response
     @paramters:     (url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping (_ data: JSON?, NSError?) -> ())
     @return: Nil
     */
    class func alamofireGetRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping (_ data: JSON?, NSError?) -> ()) {
        print(parameters as Any)
        KRProgressHUD.show(withMessage: KSConstant().PROGRESS_TITLE)
        if  CommenMethod.isInternetAvailable() == true {
            Alamofire.request(url, method: .get, parameters: parameters).responseJSON{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.result.value {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        KRProgressHUD.dismiss()
                        completionHandler(jsonObject, nil)
                    }
                    break
                case .failure( _):
                    KRProgressHUD.dismiss()
                    CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: (response.result.error?.localizedDescription)!, view: viewcontroller, completion: {})
                }
            }
        }else {
            KRProgressHUD.dismiss()
            CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: KSConstant().MESSAGE, view: viewcontroller, completion: {})
        }
    }
    
    /**
     @discussion:    function to call the service for JSON response
     @paramters:     (url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping (_ data: JSON?, NSError?) -> ())
     @return: Nil
     */
    class func alamofirePostRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping (_ data: JSON?, NSError?) -> ()) {
        print(parameters as Any)
        KRProgressHUD.show(withMessage: KSConstant().PROGRESS_TITLE)
        if  CommenMethod.isInternetAvailable() == true {
            Alamofire.request(url, method: .post, parameters: parameters).responseJSON{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.result.value {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        KRProgressHUD.dismiss()
                        completionHandler(jsonObject, nil)
                    }
                    break
                case .failure( _):
                    KRProgressHUD.dismiss()
                    CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: (response.result.error?.localizedDescription)!, view: viewcontroller, completion: {})
                }
            }
        }else {
            KRProgressHUD.dismiss()
            CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: KSConstant().MESSAGE, view: viewcontroller, completion: {})
        }
    }
    
    class func alamofirePostRequestWithOutLoader(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping (_ data: JSON?, NSError?) -> ()) {
        print(parameters as Any)
        if  CommenMethod.isInternetAvailable() == true {
            Alamofire.request(url, method: .post, parameters: parameters).responseJSON{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.result.value {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        completionHandler(jsonObject, nil)
                    }
                    break
                case .failure( _):
                    CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: (response.result.error?.localizedDescription)!, view: viewcontroller, completion: {})
                }
            }
        }else {
            CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: KSConstant().MESSAGE, view: viewcontroller, completion: {})
        }
    }
    
    class func alamofirePostRequestWithDictonary(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping (_ data: JSON?, NSError?, NSDictionary) -> ()) {
        print(parameters as Any)
        if  CommenMethod.isInternetAvailable() == true {
            KRProgressHUD.show(withMessage: KSConstant().PROGRESS_TITLE)
            Alamofire.request(url, method: .post, parameters: parameters).responseJSON{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let json = response.result.value {
                        print("JSON: \(json)")
                        let jsonObject = JSON(json)
                        KRProgressHUD.dismiss()
                        completionHandler(jsonObject, nil, response.result.value as! NSDictionary)
                    }
                    break
                case .failure( _):
                    KRProgressHUD.dismiss()
                    
                    CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: (response.result.error?.localizedDescription)!, view: viewcontroller) {}
                }
            }
        }else {
            KRProgressHUD.dismiss()
            
            CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: KSConstant().MESSAGE, view: viewcontroller){}
        }
    }
    
    
    class func alamofirePostRequestWithImage(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?,imageData: Data?, completionHandler: @escaping (_ data: JSON?, NSError?) -> ()) {
        print(parameters as Any)
        if  CommenMethod.isInternetAvailable() == true {
            
            let headers: HTTPHeaders = [
                
                "Content-type": "multipart/form-data"
            ]
            KRProgressHUD.show()
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters! {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if let data = imageData{
                    multipartFormData.append(data, withName: ("profile_photo"), fileName: "image.png", mimeType: "image/png")
                }
                
            }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (response) in
                switch response {
                case .success(let upload, _, _):
                    print(response)
                    upload.responseJSON(completionHandler: { (response) in
                        // if let json = response {
                        print("JSON: \(response)")
                        let jsonObject = JSON(response)
                        KRProgressHUD.dismiss()
                        completionHandler(jsonObject, nil)
                        //  }
                    })
                    
                    break
                case .failure(let _):
                    KRProgressHUD.dismiss()
                    CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: (""), view: viewcontroller) {}
                    //  CUPUtility.showAlertMessage(title: CUPConstant().TITLE, message: (error.localizedDescription), view: viewcontroller)
                }
            }
        }else {
            KRProgressHUD.dismiss()
            CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: (""), view: viewcontroller) {}
            //CUPUtility.showAlertMessage(title: CUPConstant().TITLE, message: CUPConstant().MESSAGE, view: viewcontroller)
        }
    }
    
    
    class func alamofirePostRequestUploadMultipleImage(url:String,image:UIImage ,viewcontroller : UIViewController!, parameters:[String:AnyObject]!,  completionHandler: @escaping (_ data: JSON?, NSError?, NSDictionary) -> ()) {
        print(parameters as Any)
        KRProgressHUD.show()
        if  CommenMethod.isInternetAvailable() == true {
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters! {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                let imagedata = UIImageJPEGRepresentation(image, 7.0)
                multipartFormData.append(imagedata!, withName: "profile_photo", fileName: "image01.png", mimeType: "image/png")
            }, usingThreshold: UInt64.init(), to: url, method: .post, headers: nil) { (result) in
                switch result{
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print("Succesfully uploaded")
                        
                        if let json = response.result.value {
                            print("JSON: \(json)")
                            let jsonObject = JSON(json)
                            KRProgressHUD.dismiss()
                            completionHandler(jsonObject, nil, response.result.value as! NSDictionary)
                        }
                        if let err = response.error{
                            print(err)
                            KRProgressHUD.dismiss()
                            CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: (response.result.error?.localizedDescription)!, view: viewcontroller) {}
                            return
                        }
                    }
                case .failure( _):
                    KRProgressHUD.dismiss()
                    break
                    //GPIMUtility.showAlertMessage(title: GPIMConstant().TITLE, message: (response.result.error?.localizedDescription)!, view: viewcontroller)
                }
            }
        }
        else {
            KRProgressHUD.dismiss()
            CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: (""), view: viewcontroller) {}
            
        }
    }
    
    
}
