//  ProjectVC.swift
//  Zoomate
//  Created by Koshal Saini on 03/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.


import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD
class ProjectVC: UIViewController {
    var viewController:EditProfileVC!
    
    var objExperienceLevelModel:ExperienceLevelModel?
    var objProjectVM = ProjectVM()    
    var dict_Specialties = NSMutableDictionary()
    
    @IBOutlet weak var lbl_SkillsCount: UILabel!
    @IBOutlet weak var cv_Project: UICollectionView!
    @IBOutlet weak var btn_Next: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cv_Project.allowsSelection = true
        self.cv_Project.allowsMultipleSelection = true
        // Do any additional setup after loading the view.
        self.lbl_SkillsCount.text  = String(format:"0/%d",(objExperienceLevelModel?.objSpecialty.count)!)
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
    
    
    @IBAction func tapNextButton(_ sender: Any) {
        let parameters = ["userId":UserDefaults.standard.value(forKey: "user_id"),"specialties":self.dict_Specialties.allValues]
        objProjectVM.callAddExperienceSkillsWS(viewController: self, parameters: parameters as NSDictionary) { responseObject in
            let objVC = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
            objVC.objModel = responseObject
            self.navigationController?.pushViewController(objVC, animated: true)
        }
    }
}


extension ProjectVC:UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (objExperienceLevelModel?.objSpecialty.count)!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        
        cell.lbl_Title.text = String(format:"%@", (objExperienceLevelModel?.objSpecialty[indexPath.row].specialty)!)
        cell.lbl_Title.layer.cornerRadius = cell.lbl_Title.frame.height/2
        if self.dict_Specialties.count > 0 {
            if self.dict_Specialties.object(forKey: String(format: "%d", indexPath.row)) as? String == String(format: "%@", (objExperienceLevelModel?.objSpecialty[indexPath.row].specialty)!){
                cell.lbl_Title.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.631372549, blue: 0.9607843137, alpha: 1)
                cell.lbl_Title.layer.borderColor = #colorLiteral(red: 0.2274509804, green: 0.631372549, blue: 0.9607843137, alpha: 1)
                cell.lbl_Title.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else {
                cell.lbl_Title.backgroundColor = .clear
                cell.lbl_Title.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.lbl_Title.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }else {
            cell.lbl_Title.layer.borderWidth = 0.5
            cell.lbl_Title.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.lbl_Title.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.lbl_Title.backgroundColor = .clear
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ProjectCell
        
        if self.dict_Specialties.count > 0 {
            if self.dict_Specialties.value(forKey: String(format: "%d", indexPath.row)) as? String == String(format: "%@", (objExperienceLevelModel?.objSpecialty[indexPath.row].specialty)!) {
                self.dict_Specialties.removeObject(forKey: String(format: "%d", indexPath.row))
                self.lbl_SkillsCount.text  = String(format:"%d/%d",self.dict_Specialties.count,(objExperienceLevelModel?.objSpecialty.count)!)
                print(self.dict_Specialties)
                self.cv_Project.reloadData()
            }else {
                self.dict_Specialties.setObject(cell.lbl_Title.text!, forKey: String(format: "%d", indexPath.row) as NSCopying)
                self.lbl_SkillsCount.text  = String(format:"%d/%d",self.dict_Specialties.count,(objExperienceLevelModel?.objSpecialty.count)!)
                print(self.dict_Specialties)
                self.cv_Project.reloadData()
            }
        }else {
            self.dict_Specialties.setObject(cell.lbl_Title.text!, forKey: String(format: "%d", indexPath.row) as NSCopying)
            self.lbl_SkillsCount.text  = String(format:"%d/%d",self.dict_Specialties.count,(objExperienceLevelModel?.objSpecialty.count)!)
            print(self.dict_Specialties)
            self.cv_Project.reloadData()
        }
    }
}


class ProjectCell: UICollectionViewCell {
    @IBOutlet weak var lbl_Title: UILabel!
}


