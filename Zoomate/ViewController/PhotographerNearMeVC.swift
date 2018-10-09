//
//  PhotographerNearMeVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 03/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class PhotographerNearMeVC: UIViewController {
    
    var arr_UsersList:UsersListModel?
    
    
    @IBOutlet weak var tbl_Photographer: UITableView!
    @IBOutlet weak var floatRatingView: FloatRatingView!
    @IBOutlet var viewDistanceFilter: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callGetUserList(type: "", lat: "", lng: "")
      UserDefaults.standard.set("forLeftMenu", forKey: "LeftMenu")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    // MARK: - Custom Method
    func callGetUserList(type:String, lat:String, lng:String) {
        let param = ["userId":UserDefaults.standard.value(forKey: "user_id"),
                     "type":type,
                     "lat":lat,
                     "lng":lng]
        UserListVM.callGetUserList(viewController: self, parameters: param as NSDictionary) { responseObject in
            print(responseObject)
            self.arr_UsersList = responseObject
            self.tbl_Photographer.reloadData()
        }
    }

    // MARK: -
    // MARK: - UIButton Action
    @IBAction func tapBackButton(_ sender: Any) {
       panel?.openLeft(animated: true)
    }
    
    @IBAction func tapQualityButton(_ sender: Any) {
        self.viewDistanceFilter.removeFromSuperview()
        self.callGetUserList(type: "rating", lat: "", lng: "")
    }
    
    @IBAction func tapDistanceButton(_ sender: Any) {
        self.viewDistanceFilter.removeFromSuperview()
        self.callGetUserList(type: "", lat: KSSessionManager.sharedInstance.lat, lng: KSSessionManager.sharedInstance.lang)
    }
    
    @IBAction func tapPriceButton(_ sender: Any) {
        self.viewDistanceFilter.removeFromSuperview()
        self.callGetUserList(type: "price", lat: "", lng: "")
    }
    
    @IBAction func btnMethodDistancePopups(_ sender: Any) {
        self.viewDistanceFilter.removeFromSuperview()
    }
    
    
    @IBAction func btnMethodFiler(_ sender: Any) {
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotographerFilterVC") as! PhotographerFilterVC
        self.navigationController?.pushViewController(objVC, animated: true)
    }
    
    
    @IBAction func btnMethodDistanceFilter(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            viewDistanceFilter.frame = CGRect.init(x:0, y:80 , width: self.view.frame.size.width, height: self.view.frame.size.height - 66)
            self.view.addSubview(viewDistanceFilter)
        }else {
            self.viewDistanceFilter.removeFromSuperview()
        }
        
    }
}


extension PhotographerNearMeVC:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arr_UsersList != nil {
            return (self.arr_UsersList?.arr_UserList.count)!
        }
        else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotographerNearMeCell", for: indexPath) as! PhotographerNearMeCell
        cell.selectionStyle = .none
        cell.lbl_Name.text = (self.arr_UsersList?.arr_UserList[indexPath.row].firstName)! + " " + (self.arr_UsersList?.arr_UserList[indexPath.row].lastName)!
        cell.lbl_Description.text = self.arr_UsersList?.arr_UserList[indexPath.row].about
        cell.lbl_TotalReviews.text = (self.arr_UsersList?.arr_UserList[indexPath.row].total_rating)! + " " + "Reviews"
        cell.img_UserProfile.sd_setImage(with: URL(string: (self.arr_UsersList?.arr_UserList[indexPath.row].profilePic)!), placeholderImage: #imageLiteral(resourceName: "placeHolder"))
        cell.dataSource = self.arr_UsersList?.arr_UserList[indexPath.row].arr_Speciality
        cell.btn_Review.tag = indexPath.row
        cell.btn_Chat.tag = indexPath.row
        cell.btn_Review.addTarget(self, action: #selector(tapReviewButton), for: .touchUpInside)
        cell.btn_Chat.addTarget(self, action: #selector(self.tapChatButton), for: .touchUpInside)
        return cell
    }
    
    @objc func tapChatButton(sender: UIButton){
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        objVC.str_Id = (self.arr_UsersList?.arr_UserList[sender.tag].id)!
        self.navigationController?.pushViewController(objVC, animated: true)
    }
    
    @objc func tapReviewButton(sender: UIButton!) {
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "UserReviewsVC") as! UserReviewsVC
        objVC.str_ID = (self.arr_UsersList?.arr_UserList[sender.tag].id)!
        self.navigationController?.pushViewController(objVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 246
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // appDel.setRootViewController()
        //professional
        UserDefaults.standard.set(" ", forKey: "LeftMenu")
        UserDefaults.standard.set("Hire", forKey: "professional")
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        objVC.objeHire = "Hire"
        objVC.objID = self.arr_UsersList?.arr_UserList[indexPath.row].id
        self.navigationController?.pushViewController(objVC, animated: true)
    }
}


extension PhotographerNearMeCell:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotographerNearMeCVCell", for: indexPath) as! PhotographerNearMeCVCell
        cell.lbl_Skills.layer.cornerRadius = 15
        cell.lbl_Skills.layer.borderWidth = 1
        cell.lbl_Skills.text = dataSource![indexPath.row].specialties
        return cell
    }
    
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width/2.1)), height: CGFloat(30))
    }
}


class PhotographerNearMeCell:UITableViewCell {
    @IBOutlet weak var cv_UserProfile: UICollectionView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Availabel: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var lbl_TotalReviews: UILabel!
    @IBOutlet weak var starRating: FloatRatingView!
    @IBOutlet weak var img_UserProfile: UIImageView!
    @IBOutlet weak var btn_Review: UIButton!
    @IBOutlet weak var btn_Chat: UIButton!
    
    var dataSource : [specialityModel]? {
        didSet {
            cv_UserProfile.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cv_UserProfile.delegate = self
        cv_UserProfile.dataSource = self
    }
}

class PhotographerNearMeCVCell:UICollectionViewCell {
    @IBOutlet weak var lbl_Skills: UILabel!
}





