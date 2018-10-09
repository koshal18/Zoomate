//
//  HiringVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 03/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class HiringVC: UIViewController {
    
    var str_HeaderTitle = String()
    var objLogin:LoginModel?
    var objLoginVM = LoginVM()
    var dict_Role = NSMutableDictionary()
    
    var objHiringModel = HiringVM()
    @IBOutlet weak var btn_Next: UIButton!
    @IBOutlet weak var btn_Back: UIButton!
    @IBOutlet weak var tbl_Professional: UITableView!
    @IBOutlet weak var lbl_HeaderTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        objLoginVM.fatchUserDetails(completion: { responseObject in
            print(responseObject.id ?? KSConstant().BLANK)
            self.objLogin = responseObject
        }) { (isError) in
            print("Could not fatch data")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if KSSessionManager.sharedInstance.isProfile == true {
            self.btn_Back.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        }
        else {
            self.btn_Back.setImage(#imageLiteral(resourceName: "ic_back_gray"), for: .normal)
        }
        if KSSessionManager.sharedInstance.str_ProfileType != "" {
            self.lbl_HeaderTitle.text = KSSessionManager.sharedInstance.str_ProfileType
        }
        else {
            self.lbl_HeaderTitle.text = self.str_HeaderTitle
        }
        
        if self.lbl_HeaderTitle.text == "Professional" {
            self.btn_Next.isHidden = false
        }else {
            self.btn_Next.isHidden = true
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: -
    // MARK: - UIButton Action
    @IBAction func tapBackButton(_ sender: Any) {
        if KSSessionManager.sharedInstance.isProfile == true {
            panel?.openLeft(animated: true)
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func tapNextButton(_ sender: Any) {

        let userRole = self.dict_Role.allValues
        print(userRole)
        
        let param = ["userId":self.objLogin!.id!,
                     "userRole":userRole] as [String : Any]
        objHiringModel.callSelectUserProfessionalWS(viewController: self, parameters: param as NSDictionary) { responseObject in
            
            let objVC = self.storyboard?.instantiateViewController(withIdentifier: "ExperienceLevelVC") as! ExperienceLevelVC
            objVC.objModel = responseObject
            self.navigationController?.pushViewController(objVC, animated: true)
        }
    }
}


// MARK: -
// MARK: - UITableView DataSource And Delegate Method
extension HiringVC:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (objLogin?.arr_UserRole.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HiringCell", for: indexPath) as! HiringCell
        cell.selectionStyle = .none
        
        if KSSessionManager.sharedInstance.str_ProfileType == "Professional" {
            cell.img_Tick.isHidden = false
        }else {
            cell.img_Tick.isHidden = true
        }
        
        cell.lbl_Title.text = objLogin?.arr_UserRole[indexPath.row].role
        cell.view_Background.layer.cornerRadius = 5
        cell.lbl_RandomColor.backgroundColor = CommenMethod.randomColor()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //***** Porfessional Type User *****//
        if self.lbl_HeaderTitle.text == "Professional" {
            let cell = tableView.cellForRow(at: indexPath) as! HiringCell
            if cell.isSelected {
                cell.isSelected = false
                if cell.img_Tick?.image == #imageLiteral(resourceName: "circle") {
                    if indexPath.row == 2 {
                        UserDefaults.standard.set("As Model", forKey: "model")
                        UserDefaults.standard.synchronize()
                    }
                    cell.img_Tick.image = #imageLiteral(resourceName: "circle_tick")
                    dict_Role.setObject(objLogin?.arr_UserRole[indexPath.row].role ?? "", forKey: String(format: "%d", indexPath.row) as NSCopying)
                }
                else {
                    if indexPath.row == 2 {
                        UserDefaults.standard.set("No model", forKey: "model")
                        UserDefaults.standard.synchronize()
                    }
                    cell.img_Tick.image = #imageLiteral(resourceName: "circle")
                    dict_Role.removeObject(forKey: String(format: "%d", indexPath.row))
                }
            }
        }else {//***** Hiring Type User *****//
            
            if indexPath.row == 2 {
                UserDefaults.standard.set("As Model", forKey: "model")
                UserDefaults.standard.synchronize()
            }else{
                 UserDefaults.standard.set("No model", forKey: "model")
                 UserDefaults.standard.synchronize()
            }
            
            dict_Role.removeObject(forKey: String(format: "%d", indexPath.row))
            dict_Role.setObject(objLogin?.arr_UserRole[indexPath.row].role ?? "", forKey: String(format: "%d", indexPath.row) as NSCopying)
            let userRole = dict_Role.allValues
            print(dict_Role)
            let param = ["userId":UserDefaults.standard.object(forKey:"user_id")!,
                         "userRole":userRole] as [String : Any]
            print("roleParam",param)
            
            objHiringModel.callSelectUserProfessionalWS(viewController: self, parameters: param as NSDictionary) { responseObject in
                let objVC = self.storyboard?.instantiateViewController(withIdentifier: "ExperienceLevelVC") as! ExperienceLevelVC
                objVC.objModel = responseObject
                self.navigationController?.pushViewController(objVC, animated: true)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tbl_Professional.frame.size.height/4
    }
}


class HiringCell: UITableViewCell {
    @IBOutlet weak var lbl_RandomColor: UILabel!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var img_Tick: UIImageView!
    @IBOutlet weak var view_Background: UIView!
}





