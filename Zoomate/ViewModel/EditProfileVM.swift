//
//  EditProfileVM.swift
//  Zoomate
//
//  Created by Developer on 11/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class EditProfileVM: NSObject {
    
    // url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?,imageData: Data?
    
    func callAddEditProfile(viewController:UIViewController, parameters:NSDictionary,imageData: UIImage?, completion: @escaping (EditProfileModel) -> Void) {
        
        DataManager.alamofirePostRequestUploadMultipleImage(url: BaseUrl+SelectcompleteProfessionalProfileUrl, image:imageData!, viewcontroller: viewController, parameters: parameters as? [String : AnyObject]) { responseObject, error, responseDict  in
            
            print(responseObject!)
            
            self.deleteAllData(entity: "UserEntity")
            let userData:Data = NSKeyedArchiver.archivedData(withRootObject: responseDict)
            self.saveUserDetails(userDetails: userData, completion: {
                let arryValueInfo = responseObject?.dictionaryValue
                let objModel:EditProfileModel = EditProfileModel.init(with: arryValueInfo!)
                if objModel.statuscode == 200 {
                    completion(objModel)
                }else {
                    CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: objModel.message!, view: viewController, completion: {})
                }
            })
            print(responseObject!)
            print(error.debugDescription)
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
        let entity = NSEntityDescription.entity(forEntityName: "UserEntity",in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(userDetails, forKey: "userData")
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
    func fatchUserDetails(completion: @escaping (EditProfileModel) -> Void,falure: @escaping (_ boolValue:Bool) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        let managedContext = appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            let person = result as! [NSManagedObject]
            if person.count != 0{
                let employeeDict = person[0].value(forKey: "userData") as! NSData
                let dictionary: Dictionary? = NSKeyedUnarchiver.unarchiveObject(with: employeeDict as Data) as? [String : Any]
                print(dictionary ?? "")
                let jsonObject = JSON(dictionary!)
                
                let objLoginVM : EditProfileModel = EditProfileModel.init(with: jsonObject.dictionaryValue)
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
