//
//  SignUpVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 28/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var txt_PhoneCode: UITextField!
    @IBOutlet weak var txt_PhoneNumber: UITextField!
    
    let objSignupVM = SignUpVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    // MARK: - UIButton Action
    /**
     @description - This method will used for move on previous screen.
     @parameter - (_ sender: Any)
     @return - nil
     */
    @IBAction func tapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     @description - This method will used for create user account.
     @parameter - (_ sender: Any)
     @return - nil
     */
    
    @IBAction func tapSubmitButton(_ sender: Any) {
        //***** Validate TextField *****//
       
        
        objSignupVM.validateTextField(email: self.txt_Email, password: self.txt_Password, phoneCode: self.txt_PhoneCode, phoneNumber: self.txt_PhoneNumber, viewController: self) { responseObject in
            //***** Go To Phone Code ViewController *****//
            let objVC = self.storyboard?.instantiateViewController(withIdentifier: "PhoneCodeVC") as! PhoneCodeVC
            objVC.objSignUpModel = responseObject
            self.navigationController?.pushViewController(objVC, animated: true)
        }
    }
}
