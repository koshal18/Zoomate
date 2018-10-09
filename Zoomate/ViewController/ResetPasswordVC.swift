//
//  ResetPasswordVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 28/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var txt_NewPassword: UITextField!
    @IBOutlet weak var txt_ConfirmPassword: UITextField!
    
    @IBOutlet var objChangePasswordVM: ChangePasswordVM!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func tapDoneButton(_ sender: Any) {
        //appDel.goToLoginViewController()
        let parameters = ["oldPassword":txt_NewPassword.text!,"newPassword":txt_ConfirmPassword.text!,"userId":UserDefaults.standard.value(forKey: "user_id")!]
        
        objChangePasswordVM.callChangePassword(viewController:self, parameters:parameters as NSDictionary){ (response) in
            
        }
        
    }
    
}
