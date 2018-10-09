//
//  LoginVM.swift
//  Zoomate
//
//  Created by Koshal Saini on 01/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class LoginVM: NSObject {
    
    /**
     @description: This method will be used for call Login Web Service.
     @parameters:  (viewController:UIViewController, parameters:NSDictionary, completion: @escaping (LoginModel) -> Void)
     @returns:Nil
     */
    func callLoginWS(viewController:UIViewController, parameters:NSDictionary, completion: @escaping (LoginModel) -> Void) {
        
        DataManager.alamofirePostRequestWithDictonary(url: BaseUrl+LoginURL, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { responseObject, error, responseDict in
            print(responseObject ?? KSConstant().BLANK)
            
            self.deleteAllData(entity: KSConstant().ENTITY)
            let userData:Data = NSKeyedArchiver.archivedData(withRootObject: responseDict)
            self.saveUserDetails(userDetails: userData, completion: {
                let arryValueInfo = responseObject?.dictionaryValue
                let objModel:LoginModel = LoginModel.init(with: arryValueInfo!)
                if objModel.commenModel.statuscode == 200 {
                    completion(objModel)
                }else {
                    CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.commenModel.message!, view: viewController, completion: {})
                }
            })
        }
    }
    
    /**
     @description: This method will be used for Validate TextFields.
     @parameters:  (email:UITextField, password:UITextField, lat:String, long:String, viewController:UIViewController, completion: @escaping (LoginModel) -> Void)
     @returns:Nil
     */
    func validateTextFields(phoneNumber:UITextField, phoneCode:UITextField ,email:UITextField, password:UITextField, lat:String, long:String, viewController:UIViewController, completion: @escaping (LoginModel) -> Void) {
        if (phoneNumber.text?.count)! > 0 && (phoneCode.text?.count)! > 0 && (email.text?.count)! <= 0 {
            let param = ["email":"",
                         "password":"1234567",
                         "mobile":phoneCode.text! + phoneNumber.text!,
                         "deviceType":"IOS",
                         "deviceToken":UserDefaults.standard.value(forKey: "deviceToken"),
                         "lat":lat,
                         "long":long]
            
            self.callLoginWS(viewController: viewController, parameters: param as NSDictionary) {responseObject in
                completion(responseObject)
            }
        }
        else if (phoneNumber.text?.count)! <= 0 && (phoneCode.text?.count)! <= 0 && (email.text?.count)! > 0 {
            let param = ["email":email.text!,
                         "password":password.text!,
                         "mobile":"",
                         "deviceType":"IOS",
                         "deviceToken":UserDefaults.standard.value(forKey: "deviceToken"),
                         "lat":lat,
                         "long":long]
            
            self.callLoginWS(viewController: viewController, parameters: param as NSDictionary) {responseObject in
                completion(responseObject)
            }
        }
        else if (phoneNumber.text?.count)! <= 0 && (phoneCode.text?.count)! <= 0 && (email.text?.count)! <= 0  {
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
    
    
    /**
     @description: This method will store the Login Details in core data.
     @parameter: (userDetails:Data, completion: @escaping () -> Void)
     @returns:Nil
     */
    func saveUserDetails(userDetails:Data, completion: @escaping () -> Void) {
        //***** Save all entity into core data *****//
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: KSConstant().ENTITY,in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(userDetails, forKey: KSConstant().LOGIN_DETAILS)
        do {
            try managedContext.save()
            completion()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    /**
     @description: This method will used for fatch user details.
     @parameter: (completion: @escaping (LoginModel) -> Void,falure: @escaping (_ boolValue:Bool) -> Void)
     @returns:nil
     */
    func fatchUserDetails(completion: @escaping (LoginModel) -> Void,falure: @escaping (_ boolValue:Bool) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: KSConstant().ENTITY)
        let managedContext = appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            let person = result as! [NSManagedObject]
            if person.count != 0{
                let employeeDict = person[0].value(forKey: KSConstant().LOGIN_DETAILS) as! NSData
                let dictionary: Dictionary? = NSKeyedUnarchiver.unarchiveObject(with: employeeDict as Data) as? [String : Any]
                print(dictionary ?? "")
                let jsonObject = JSON(dictionary!)
                
                let objLoginVM : LoginModel = LoginModel.init(with: jsonObject.dictionaryValue)
                completion(objLoginVM)
            }
            else{
                falure(false)
            }
        } catch {
            print("Failed")
        }
    }
    
    /**
     @description: This method will used for clear core data.
     @parameter: (entity: String)
     @returns:nil
     */
    func deleteAllData(entity: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
                try managedContext.save()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

