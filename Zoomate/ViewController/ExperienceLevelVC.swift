//
//  ExperienceLevelVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 03/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class ExperienceLevelVC: UIViewController {
    
    var objModel:HiringModel?
    var objExperienceLevelVM = ExperienceLevelVM()
    @IBOutlet weak var tbl_Skills: UITableView!
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
}


extension ExperienceLevelVC:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (objModel?.objSkills.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceLevelCell", for: indexPath) as! ExperienceLevelCell
        cell.selectionStyle = .none
        cell.lbl_Title.text = objModel?.objSkills[indexPath.row].skill
        cell.view_Background.layer.cornerRadius = 5
        cell.lbl_RandomColor.backgroundColor = CommenMethod.randomColor()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tbl_Skills.frame.size.height/4
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let param = ["userId":UserDefaults.standard.value(forKey: "user_id"),
                     "skill":objModel?.objSkills[indexPath.row].skill,
                     ]
        
        objExperienceLevelVM.callSelectUserExperienceWS(viewController: self, parameters: param as NSDictionary) { responseObject in
            let objVC = self.storyboard?.instantiateViewController(withIdentifier: "ProjectVC") as! ProjectVC
            objVC.objExperienceLevelModel = responseObject
            self.navigationController?.pushViewController(objVC, animated: true)
        }
    }
}


class ExperienceLevelCell:UITableViewCell {
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_RandomColor: UILabel!
    @IBOutlet weak var view_Background: UIView!
}







