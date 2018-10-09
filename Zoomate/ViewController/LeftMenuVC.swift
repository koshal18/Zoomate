//
//  LeftMenuVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 03/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class LeftMenuVC: UIViewController {
    
    var objLogin:LoginModel?
    var objLoginVM = LoginVM()
    
    var MenuDataHire: [String]=["Home","My Profile", "Edit Profile", "Messages",  "Gallary", "Settings","Logout"]{
        didSet {
            self.tbl_LeftMenu.reloadData()
        }
    }
    var MenuDataprofession: [String]=["My Profile", "Edit Profile", "Messages",  "Gallary", "Settings","Logout"]{
        didSet {
            self.tbl_LeftMenu.reloadData()
        }
    }
    var MenuIconsProfession:[UIImage] = [#imageLiteral(resourceName: "profile"), #imageLiteral(resourceName: "edit"), #imageLiteral(resourceName: "chat"), #imageLiteral(resourceName: "gallery"), #imageLiteral(resourceName: "setting"), #imageLiteral(resourceName: "logout")]
    var MenuIconsHire:[UIImage] = [#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "profile.png"), #imageLiteral(resourceName: "edit"), #imageLiteral(resourceName: "chat"), #imageLiteral(resourceName: "gallery"), #imageLiteral(resourceName: "setting"), #imageLiteral(resourceName: "logout")]
    
    @IBOutlet weak var lbl_Profession: UILabel!
    @IBOutlet weak var lbl_UserName: UILabel!
    @IBOutlet weak var img_UserProfile: UIImageView!
    @IBOutlet weak var tbl_LeftMenu: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objLoginVM.fatchUserDetails(completion: { responseObject in
            print(responseObject.id ?? KSConstant().BLANK)
            self.objLogin = responseObject
            self.img_UserProfile.sd_setImage(with: URL(string: self.objLogin?.profilePic ?? "Koshal Saini"), placeholderImage: #imageLiteral(resourceName: "placeHolder"))
            self.lbl_UserName.text = (self.objLogin?.firstName)! + " " + (self.objLogin?.lastName)!
            self.lbl_Profession.text = (self.objLogin?.userType)!
        }) { (isError) in
            print("Could not fatch data")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tbl_LeftMenu.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension LeftMenuVC:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MenuIconsHire.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuCell", for: indexPath) as! LeftMenuCell
        cell.selectionStyle = .none
        cell.ic_Menu.image = MenuIconsHire[indexPath.row]
        cell.lbl_Menu.text = MenuDataHire[indexPath.row]
        return cell
    }
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
            if indexPath.row == 0 {
                navigateVCWith(identifier: "PhotographerNearMeVC")
            }
            else if indexPath.row == 1 {
                navigateVCWith(identifier: "ProfileVC")
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let centerVC: ProfileVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                centerVC.objID = UserDefaults.standard.value(forKey: "user_id") as? String
                let centerNavVC: UINavigationController? = mainStoryboard.instantiateViewController(withIdentifier: "navigation") as? UINavigationController
                centerNavVC?.viewControllers = [centerVC]
                panel!.configs.bounceOnCenterPanelChange = false
                panel!.center(centerNavVC!, afterThat: {
                })
                
            }
            else if indexPath.row == 2 {
                navigateVCWith(identifier: "HiringVC")
                KSSessionManager.sharedInstance.isProfile = true
            }else if indexPath.row == 3{
                navigateVCWith(identifier:"MessageVC")
            }
            else if indexPath.row == 5 {
                navigateVCWith(identifier: "SettingsVC")
            }else if indexPath.row == 4{
                // GalleryVC
                navigateVCWith(identifier: "GalleryVC")
            }
            else if indexPath.row == 6 {
                CommenMethod.showAlertMessageWithOkAction(title: KSConstant().TITLE, message: "Are you sure you want to logout.", view: self) {
                    let domain = Bundle.main.bundleIdentifier!
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    let loginVM = LoginVM()
                    loginVM.deleteAllData(entity: KSConstant().ENTITY)
                    appDel.goToSocialMediaViewController()
                }
            }
            else {
                navigateVCWith(identifier: "ComingSoonVC")
            }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func navigateVCWith(identifier: String){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let centerVC: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: identifier)
        let centerNavVC: UINavigationController? = mainStoryboard.instantiateViewController(withIdentifier: "navigation") as? UINavigationController
        centerNavVC?.viewControllers = [centerVC]
        panel!.configs.bounceOnCenterPanelChange = false
        panel!.center(centerNavVC!, afterThat: {
        })
    }
}


class LeftMenuCell: UITableViewCell {
    @IBOutlet weak var lbl_Menu: UILabel!
    @IBOutlet weak var ic_Menu: UIImageView!
    
}





