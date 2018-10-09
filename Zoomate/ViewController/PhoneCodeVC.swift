//
//  PhoneCodeVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 28/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class PhoneCodeVC: UIViewController {
    
    var objPhoneCodeVM = PhoneCodeVM()
    var objSignUpModel: SignUpModel?
    @IBOutlet weak var txt_OTPCode: UITextField!
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
    /**
     @description - This method will used for move on previous screen.
     @parameter - (_ sender: Any)
     @return - nil
     */
    @IBAction func tapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     @description - This method will used for resend OTP.
     @parameter - (_ sender: Any)
     @return - nil
     */
    @IBAction func tapResendButton(_ sender: Any) {
        let param = ["userId":objSignUpModel?.id!]
        objPhoneCodeVM.callResendOTPWS(viewController: self, parameters: param as NSDictionary) {}
    }
    
    /**
     @description - This method will used for submit OTP.
     @parameter - (_ sender: Any)
     @return - nil
     */
    
    @IBAction func tapDoneButton(_ sender: Any) {
        //***** UITextField Validation *****//
        objPhoneCodeVM.validateTextField(otp: self.txt_OTPCode!, userID: (objSignUpModel?.id!)!, viewController: self) {
            //***** Move On Home Screen *****//
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
