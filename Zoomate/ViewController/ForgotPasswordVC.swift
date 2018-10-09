//
//  ForgotPasswordVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 28/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet var objForgotPasswordVM: ForgotPasswordVM!
    @IBOutlet weak var txt_Email: UITextField!
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
    
    @IBAction func tapSendButton(_ sender: Any) {
        
        let parameters = ["email":txt_Email.text]
    objForgotPasswordVM.callForgotPassword(viewController:self, parameters:parameters as NSDictionary){response in
        
    
        
        
        }
        
    }
    
}
