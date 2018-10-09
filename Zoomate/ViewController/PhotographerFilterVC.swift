//
//  PhotographerFilterVC.swift
//  Zoomate
//
//  Created by Developer on 16/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class PhotographerFilterVC: UIViewController {
    @IBOutlet weak var txtfldAge: UITextField!
   
    @IBOutlet weak var txtfldSkillLevel: UITextField!
    @IBOutlet weak var txtfldSkillSet: UITextField!
    @IBOutlet weak var txtfldPrice: UITextField!
    @IBOutlet weak var txtfldReviews: UITextField!
    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btn_Male: UIButton!
    @IBOutlet weak var btn_Female: UIButton!
    
    var city:String?
    var state:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: -
    // MARK: - UIButton Action
    @IBAction func btnMethodState(_ sender: Any) {
        let values = ["Alabama", "Alaska", "Arizona", "Arkansas", "California"]
        DPPickerManager.shared.showPicker(title: "STATE", selected: "", strings: values) { (value, index, cancel) in
            if !cancel {
                // TODO: you code here
                self.state = value
                debugPrint(value as Any)
                self.btnState.setTitle(value, for: .normal)
            }
        }
    }
    
    
    @IBAction func btnMethodCity(_ sender: Any) {
        let values = ["New York", "Los Angeles", "Chicago", "Houston","Philadelphia"]
        DPPickerManager.shared.showPicker(title: "CITY", selected: "", strings: values) { (value, index, cancel) in
            if !cancel {
                // TODO: you code here
                debugPrint(value as Any)
               // self.btn = value
                self.btnCity.setTitle(value, for: .normal)
                
            }
        }
    }
    
    
    @IBAction func btMethodLocation(_ sender: Any) {
        let values = ["New York", "Los Angeles", "Chicago", "Houston","Philadelphia"]
        DPPickerManager.shared.showPicker(title: "CITY", selected: "", strings: values) { (value, index, cancel) in
            if !cancel {
                // TODO: you code here
                debugPrint(value as Any)
               // self.city = value
                self.btnLocation.setTitle(value, for: .normal)
            }
        }
    }
    
    
    @IBAction func tapMaleButton(_ sender: Any) {
        btn_Male.setImage(UIImage(named: "male.png"), for: UIControlState.normal)
        btn_Female.setImage(UIImage(named: "female.png"), for: UIControlState.normal)
    }
    
    
    @IBAction func tapFemaleButton(_ sender: Any) {
        btn_Female.setImage(UIImage(named: "male.png"), for: UIControlState.normal)
        btn_Male.setImage(UIImage(named: "female.png"), for: UIControlState.normal)
    }
    
    
    @IBAction func btnMethodback(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



