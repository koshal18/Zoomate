//
//  LoginVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 28/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import CoreLocation

class LoginVC: UIViewController {
    
    var str_Lat = String()
    var str_Long = String()
    
    var objLoginVM = LoginVM()
    var objLoginModel: LoginModel?
    var locationManager:CLLocationManager!
    
    @IBOutlet weak var txt_PhoneCode: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var txt_PhoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        txt_PhoneCode.text = "+91"
        self.determineMyCurrentLocation()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    // MARK: -
    // MARK: - UIButton Action
    /**
     @description - This method will used move on previous screen.
     @parameter - (_ sender: Any)
     @return - nil
     */
    @IBAction func tapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     @description - This method will used for login with Twitter.
     @parameter - (_ sender: Any)
     @return - nil
     */
    @IBAction func tapSignInButton(_ sender: Any) {
        //***** Call Login Web Servic *****//
        objLoginVM.validateTextFields(phoneNumber: self.txt_PhoneNumber, phoneCode: self.txt_PhoneCode, email: self.txt_Email, password: self.txt_Password, lat: str_Lat, long: str_Long, viewController: self) { responseObject in
            self.objLoginModel = responseObject
            UserDefaults.standard.set(responseObject.id, forKey: "user_id")
            UserDefaults.standard.synchronize()
            //***** Move on Home View Controller *****//
            if  self.objLoginModel?.is_completed == "1"{
                appDel.goToPhotographerViewController()
                UserDefaults.standard.set(true, forKey:"autoLogin")
                UserDefaults.standard.synchronize()
            }else{
                UserDefaults.standard.set(true, forKey:"autoLogin")
                CommenMethod.goToViewController(identifier: "ProfessionalVC", storyboard: self.storyboard!, navigation: self.navigationController!)
            }
        }
    }
    
    
    /**
     @description - This method will used for reset Forgot Password.
     @parameter - (_ sender: Any)
     @return - nil
     */
    @IBAction func tapForgotPasswordButton(_ sender: Any) {
        CommenMethod.goToViewController(identifier: "ForgotPasswordVC", storyboard: self.storyboard!, navigation: self.navigationController!)
    }
    
    
    // MARK: -
    // MARK: - Current Location
    /**
     @description - This method will used for get User Current Location.
     @parameter - nil
     @return - nil
     */
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    
}


// MARK: -
// MARK: - Current Location
extension LoginVC: CLLocationManagerDelegate {
    /**
     @description - This method will used for Update User Current Location.
     @parameter - (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
     @return - nil
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        self.str_Lat = String(format: "%f", userLocation.coordinate.latitude)
        self.str_Long = String(format: "%f", userLocation.coordinate.longitude)
        locationManager.stopUpdatingLocation()
    }
    
    /**
     @description - This method will used for get user locations error.
     @parameter - (_ manager: CLLocationManager, didFailWithError error: Error)
     @return - nil
     */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        CommenMethod.showKSAlertMessage(title: KSConstant().TITLE, message: error.localizedDescription, view: self) {}
    }
}







