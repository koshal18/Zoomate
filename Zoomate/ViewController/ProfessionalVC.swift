//
//  ProfessionalVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 03/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class ProfessionalVC: UIViewController {
    
    var objProfessionalVM = ProfessionalVM()
    var objLoginModel:LoginModel?
    let objLoginVM = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: -
    // MARK: - UIButton Action
    @IBAction func tapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func tapProfessionalButton(_ sender: Any) {
        UserDefaults.standard.set("As Professional", forKey: "professional")
        
        let param = ["userId":self.objLoginModel?.id,
                     "usertype":"Professional"]
        //*****--------------------- Call Select User Type Web Service ---------------------*****//
        objProfessionalVM.callSelectUserTypeWS(viewController: self, parameters: param as NSDictionary) { responseObject in
            UserDefaults.standard.set(false, forKey: "is_Hire")
            UserDefaults.standard.synchronize()
            let objVC = self.storyboard?.instantiateViewController(withIdentifier: "HiringVC") as! HiringVC
            objVC.str_HeaderTitle = "Professional"
            KSSessionManager.sharedInstance.str_ProfileType = "Professional"
            KSSessionManager.sharedInstance.isProfile = false
            self.navigationController?.pushViewController(objVC, animated: true)
        }
    }
    
    
    @IBAction func tapHiringButton(_ sender: Any) {
        UserDefaults.standard.set("As Hiring", forKey: "Hiring")
        let param = ["userId":self.objLoginModel?.id,
                     "usertype":"Hiring"]
        //*****--------------------- Call Select User Type Web Service ---------------------*****//
        objProfessionalVM.callSelectUserTypeWS(viewController: self, parameters: param as NSDictionary) { responseObject in
            UserDefaults.standard.set(true, forKey: "is_Hire")
            UserDefaults.standard.synchronize()
            let objVC = self.storyboard?.instantiateViewController(withIdentifier: "HiringVC") as! HiringVC
            objVC.str_HeaderTitle = "Hiring"
            KSSessionManager.sharedInstance.str_ProfileType = "Hiring"
            KSSessionManager.sharedInstance.isProfile = false
            self.navigationController?.pushViewController(objVC, animated: true)
        }
    }
}
