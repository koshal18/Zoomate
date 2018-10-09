//
//  HomeVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 28/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import TwicketSegmentedControl
import SDWebImage

class ProfileVC: UIViewController {
    
    var objLoginVM = LoginVM()
    var objModelEdit:EditProfileModel?
    var objEditProfileVM = EditProfileVM()
    var objProfileVM = ProfileVM()
    var objProfileModel:ProfileModel?
    var objUserInfo:UserInfoModel?
    
    var imagePicker = UIImagePickerController()
    var objeHire:String?
    var objID:String?
    
    
    @IBOutlet weak var lbl_Reviews: UILabel!
    @IBOutlet weak var btnNavigation: UIButton!
    @IBOutlet weak var floatRatingView: FloatRatingView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var view_Header: UIView!
    @IBOutlet weak var lbl_Pricing: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var view_Book: UIView!
    @IBOutlet weak var view_Segment: UIView!
    @IBOutlet weak var view_Controller: UIView!
    @IBOutlet var view_AboutMe: UIView!
    @IBOutlet weak var tbl_AboutMe: UITableView!
    @IBOutlet weak var cv_AboutMe: UICollectionView!
    @IBOutlet weak var btnBookNow: UIButton!
    
    
    //*****-------- Gallery View --------*****//
    @IBOutlet var view_Gallery: UIView!
    @IBOutlet weak var cv_Gallary: UICollectionView!
    @IBOutlet weak var img_GallaryHeader: UIImageView!
    
    
    
    //*****-------- Pricing View --------*****//
    @IBOutlet var view_Pricing: UIView!
    @IBOutlet weak var tbl_Pricing: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Call Get User Details Web Service
        self.callApiUserInfo()
        
        // Reset float rating view's background color
        floatRatingView.backgroundColor = UIColor.clear
        floatRatingView.delegate = self
        floatRatingView.contentMode = UIViewContentMode.scaleAspectFit
        floatRatingView.type = .halfRatings
        
        // Segmented control init
        if objeHire == "Hire"{
            btnBookNow.isHidden = false
            btnNavigation.setImage(UIImage(named:"ic_Back.png"), for: .normal)
        }
        else {
            btnNavigation.setImage(UIImage(named: "menu.png"), for:.normal)
            btnBookNow.isHidden = true
        }
        //// LeftMenu
        self.initilizeSegmentController()
        
        let height = (UIScreen.main.bounds.size.height - (self.view_Header.frame.size.height + self.view_Segment.frame.size.height))
        self.view_AboutMe.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        self.view_Controller.addSubview(self.view_AboutMe)
        self.tbl_AboutMe.reloadData()
        self.cv_AboutMe.reloadData()
        CircleImage()
    }
    
    
    
    // MARK: -
    // MARK: - CallWebService
    func callApiUserInfo() {
        
        let param:NSDictionary = ["userId":self.objID ?? ""]
        UserInfoVM.callUserInfo(viewController:self, parameters:param){ response in
            self.objUserInfo = response
            self.SetProfileData()
            self.tbl_AboutMe.reloadData()
            self.cv_AboutMe.reloadData()
        }
    }
    
    
    func CircleImage(){
        profileImg.layer.masksToBounds = false
        profileImg.layer.cornerRadius = profileImg.frame.height/2
        profileImg.clipsToBounds = true
    }
    
    
    // MARK: -
    // MARK: - UIButton Action
    @IBAction func tapBookNow(_ sender: Any) {
        let param = ["to_id":self.objID!,"from_id":UserDefaults.standard.value(forKey: "user_id")!]
        
        BooknowVM.callBookNow(viewController:self, parameters:param as NSDictionary){ response in
            self.btnBookNow.setTitle("Booked", for:.normal)
            print(response.message!)
        }
    }
    
    
    @IBAction func tapRightMenuButton(_ sender: Any) {
        if objeHire == "Hire"{
            self.navigationController?.popViewController(animated: true)
        }else {
            panel?.openLeft(animated: true)
        }
    }
    
    
    @IBAction func tapProfileButton(_ sender: Any) {
        self.view_Book.frame = self.view.frame
        self.view_Book.center = self.view.center
        self.view.addSubview(self.view_Book)
    }
    
    
    @IBAction func tapYesButton(_ sender: Any) {
        self.view_Book.removeFromSuperview()
    }
    
    @IBAction func tapCancelButton(_ sender: Any) {
        self.view_Book.removeFromSuperview()
    }
    
    
    // MARK: -
    // MARK: - UICustom Method
    func initilizeSegmentController() {
        let str_Title = ["About Me", "Gallery", "Pricing"]
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        let segmentedControl = TwicketSegmentedControl(frame: frame)
        segmentedControl.sliderBackgroundColor = #colorLiteral(red: 0.1764705882, green: 0.7215686275, blue: 0.862745098, alpha: 1)
        segmentedControl.setSegmentItems(str_Title)
        segmentedControl.delegate = self
        self.view_Segment.addSubview(segmentedControl)
    }
    
    
    func SetProfileData(){
        self.profileImg.sd_setImage(with: URL(string:self.objUserInfo?.profilePic ?? ""), placeholderImage:#imageLiteral(resourceName: "placeHolder") )
        self.profileName.text = (self.objUserInfo?.firstName)! + "" + (self.objUserInfo?.lastName)!
        lbl_Pricing.text = String(format:"%@ %@","$",(self.objUserInfo?.price)!)
        lblPrice.text = String(format:"%@ %@","$",(self.objUserInfo?.price)!)
        self.lbl_Reviews.text = (self.objUserInfo?.price)! + " " + "Reviews"
    }
    
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openGallary() {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func callGetGalleryImagesWS() {
        let param = ["userId":self.objID]
        objProfileVM.callGetGalleryImages(viewController: self, parameters: param as NSDictionary) { responseObject in
            self.objProfileModel = responseObject
            if self.objProfileModel != nil {
                self.img_GallaryHeader.sd_setImage(with: URL(string: (self.objProfileModel?.objImages[0].image)!), placeholderImage: #imageLiteral(resourceName: "placeHolder"))
            }
            self.cv_Gallary.reloadData()
        }
    }
}
// MARK:-
// MARK:- Segement Controller
extension ProfileVC: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        if segmentIndex == 0 {
            self.view_Pricing.removeFromSuperview()
            self.view_Gallery.removeFromSuperview()
            self.view_AboutMe.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view_Controller.frame.size.height)
            self.view_Controller.addSubview(self.view_AboutMe)
            self.tbl_AboutMe.reloadData()
            self.cv_AboutMe.reloadData()
        }
        else if segmentIndex == 1 {
            self.view_Pricing.removeFromSuperview()
            self.view_AboutMe.removeFromSuperview()
            self.view_Gallery.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view_Controller.frame.size.height)
            self.view_Controller.addSubview(self.view_Gallery)
            self.callGetGalleryImagesWS()
        }
        else if segmentIndex == 2 {
            self.view_AboutMe.removeFromSuperview()
            self.view_Gallery.removeFromSuperview()
            self.view_Pricing.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view_Controller.frame.size.height)
            self.view_Controller.addSubview(self.view_Pricing)
            self.tbl_Pricing.reloadData()
        }
    }
}


// MARK:-
// MARK:- UITableView DataSource And Delegate Method
extension ProfileVC:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tbl_AboutMe == tableView {
            if self.objUserInfo != nil {
                return 3
            }else {
                return 0
            }
        }else {
            return 4
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.tbl_AboutMe == tableView { // About Me
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTblCell", for: indexPath) as! ProfileTblCell
            cell.selectionStyle = .none
            if indexPath.row == 0 {
                cell.lbl_Title.text = "Location"
                cell.lbl_Description.text = String(format:"%@ %@ %@",(objUserInfo?.city)!,",",(objUserInfo?.state)!)
                
            }
            else if indexPath.row == 1 {
                cell.lbl_Title.text = "Portfolio"
                cell.lbl_Description.text = objUserInfo?.website
            }
            else if indexPath.row == 2 {
                cell.lbl_Title.text = "Introduction:"
                cell.lbl_Description.text = objUserInfo?.about
            }
            return cell
        }else { // Pricing
            let cell = tableView.dequeueReusableCell(withIdentifier: "PricingCell", for: indexPath) as! ProfileTblCell
            cell.selectionStyle = .none
            if indexPath.row == 0 {
                cell.lbl_Title.text = "100-300/hr depending on project nature."
            }
            else if indexPath.row == 1 {
                cell.lbl_Title.text = "Rate is negotiable"
            }
            else if indexPath.row == 2 {
                cell.lbl_Title.text = "Payment Plan Accepted"
            }
            else if indexPath.row == 3 {
                cell.lbl_Title.text = "Post editing not included"
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


// MARK:-
// MARK:- UICollectionView DataSource And Delegate Method
extension ProfileVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == cv_Gallary {
            if self.objProfileModel != nil {
                if objeHire == "Hire"{
                    return (self.objProfileModel?.objImages.count)!
                }else {
                    return (self.objProfileModel?.objImages.count)! + 1
                }
            }else {
                return 0
            }
        }else {
            if self.objModelEdit != nil {
                return (objModelEdit?.objSpecialt.count)!
            }else {
                return 0
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cv_Gallary {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! ProfileCVCell
            if objeHire == "Hire"{
                cell.img_Gallery.sd_setImage(with: URL(string: (self.objProfileModel?.objImages[indexPath.row].image)!), completed: nil)
            }else {
                if indexPath.row == 0 {
                    cell.img_Gallery.image = #imageLiteral(resourceName: "plus")
                }else {
                    cell.img_Gallery.sd_setImage(with: URL(string: (self.objProfileModel?.objImages[indexPath.row - 1].image)!), completed: nil)
                }
            }
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCVCell", for: indexPath) as! ProfileCVCell
            cell.lbl_Title.text = objModelEdit?.objSpecialt[indexPath.item].specialties
            cell.lbl_Title.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            cell.lbl_Title.layer.cornerRadius = cell.lbl_Title.frame.size.height/2
            cell.lbl_Title.layer.borderWidth = 0.5
            cell.lbl_Title.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            return cell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cv_Gallary {
            if objeHire == "Hire"{
                self.img_GallaryHeader.sd_setImage(with: URL(string: (self.objProfileModel?.objImages[indexPath.row].image)!), completed: nil)
            }else {
                if indexPath.row == 0 {
                    imagePicker.delegate = self
                    let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                        self.openCamera()
                    }))
                    alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                        self.openGallary()
                    }))
                    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else {
                    self.img_GallaryHeader.sd_setImage(with: URL(string: (self.objProfileModel?.objImages[indexPath.row - 1].image)!), completed: nil)
                }
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cv_Gallary {
            var collectionViewSize = collectionView.frame.size
            collectionViewSize.width = collectionViewSize.width/5.0 //Display Three elements in a row.
            collectionViewSize.height = collectionViewSize.width
            return collectionViewSize
        }else {
            var collectionViewSize = collectionView.frame.size
            collectionViewSize.width = collectionViewSize.width/5.0 //Display Three elements in a row.
            collectionViewSize.height = collectionViewSize.height/2.5
            return collectionViewSize
        }
    }
}


extension ProfileVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.uploadImage(image: pickedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func uploadImage(image:UIImage) {
        let param = ["userId":UserDefaults.standard.value(forKey: "user_id")]
        objProfileVM.callUploadGalleryImage(viewController: self, parameters: param as NSDictionary, imageData: image) {
            self.callGetGalleryImagesWS()
        }
    }
}


// MARK:-
// MARK:- UITableViewCell
class ProfileTblCell:UITableViewCell {
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
}


// MARK:-
// MARK:- UICollectionViewCell
class ProfileCVCell:UICollectionViewCell {
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var img_Gallery: UIImageView!
}


extension ProfileVC: FloatRatingViewDelegate {
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        
    }
    
}
