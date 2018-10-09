//
//  EditProfileVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 03/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var objModel:SpecialitiesModel?
    var imagePicker = UIImagePickerController()
    var strGender:String?
    var specilities = [NSMutableArray]()
    var valueSpl:String?
    var objEditVM = EditProfileVM()
    var city:String?
    var state:String?
    var age:String?
    
    @IBOutlet weak var txtfldPage: UITextField!
    @IBOutlet weak var imgEditProfile: UIImageView!
    @IBOutlet weak var txtfldWebsite: UITextField!
    @IBOutlet weak var txtfldBio: UITextField!
    @IBOutlet weak var txtfldEmail: UITextField!
    @IBOutlet var viewModelEditProfile: EditProfileVM!
    @IBOutlet weak var btnFemail: UIButton!
    @IBOutlet weak var txtfldSkillLevel: UITextField!
    @IBOutlet weak var txtfldPrivatePrice: UITextField!
    @IBOutlet weak var txtfldSkillSet: UITextField!
    @IBOutlet weak var txtfldAge: UITextField!
    
    @IBOutlet weak var txtfldFirstName: UITextField!
    @IBOutlet weak var txtfldLastName: UITextField!
    @IBOutlet weak var txtfldPhoneNumber: UITextField!
    
    @IBOutlet weak var viewModelFilter: UIView!
    @IBOutlet weak var textFieldAge: UITextField!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblEthnicity: UILabel!
    @IBOutlet weak var lblBust: UILabel!
    
    @IBOutlet weak var txtfldHeight: UITextField!
    @IBOutlet weak var txtfldWeight: UITextField!
    @IBOutlet weak var txtfldEthnicity: UITextField!
    @IBOutlet weak var txtfldBust: UITextField!
    
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    
    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnDate: UIButton!
    
    @IBOutlet weak var lc_ModelFilterHeight: NSLayoutConstraint!
    var jsonState = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CircleImage()
        SetProfileData()
        strGender = "Male"
        
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                jsonState = jsonResult as! [String:AnyObject] as NSDictionary
                print(jsonState.allKeys)
                if let jsonResult = jsonResult as? [String:AnyObject]  {
                 //  let person = jsonResult as? [String:AnyObject]
                    print("stateStateData",jsonResult.keys)
                    print("stateCityData",jsonResult.values)
                    // do stuff
                }
            } catch {
                // handle error
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func CircleImage(){
        imgEditProfile.layer.masksToBounds = false
        imgEditProfile.layer.cornerRadius = imgEditProfile.frame.height/2
        imgEditProfile.clipsToBounds = true
    }
    
    
    func SetProfileData(){
        if UserDefaults.standard.object(forKey:"model") as? String == "As Model"{
            self.lc_ModelFilterHeight.constant = 252
            self.view.updateConstraintsIfNeeded()
        }
        else{
            self.lc_ModelFilterHeight.constant = 0
            self.view.updateConstraintsIfNeeded()
        }
        
        // No model
        txtfldPage.text = objModel?.page
        txtfldWebsite.text = objModel?.website
        txtfldFirstName.text = objModel?.firstName
        txtfldLastName.text = objModel?.lastName
        txtfldBio.text = objModel?.about
        txtfldEmail.text = objModel?.email
        txtfldSkillLevel.text = objModel?.skill
        txtfldPrivatePrice.text = objModel?.price
        txtfldPhoneNumber.text = objModel?.phone_num
        txtfldAge.text = objModel?.age
        self.btnState.setTitle(objModel?.state, for: .normal)
        self.btnCity.setTitle(objModel?.city, for: .normal)
        txtfldPrivatePrice.text = objModel?.price
        txtfldPhoneNumber.text = objModel?.phone_num
        print(objModel?.profilePic ?? "")
        
        // Model filter
        txtfldHeight.text = objModel?.height
        txtfldWeight.text = objModel?.weight
        txtfldEthnicity.text = objModel?.ethnicity
        txtfldBust.text = objModel?.bust
        
        imgEditProfile.sd_setImage(with: URL(string:objModel?.profilePic ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        
        for dict in (objModel?.objSpecialty)!{
            valueSpl = dict.specialties
            print(valueSpl!)
        }
        txtfldSkillSet.text = valueSpl
    }
    
    
    // MARK: -
    // MARK: - UIButton Action
    @IBAction func tapCancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: -
    // MARK: - image picker
    @IBAction func btnMethodCamera(_ sender: Any) {
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
    }
    
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
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
    
    
    //MARK: - ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // imageViewPic.contentMode = .scaleToFill
            imgEditProfile.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tapDoneButton(_ sender: Any) {
        let parameters:NSDictionary = ["userId":UserDefaults.standard.value(forKey: "user_id")!,
                                       "firstName":txtfldFirstName.text!,
                                       "lastName":txtfldLastName.text!,
                                       "gender":objModel?.gender! ?? "",
                                       "about":txtfldBio.text!,
                                       "city":objModel?.city! ?? "",
                                       "state":objModel?.state! ?? "",
                                       "height":txtfldHeight.text!,
                                       "weight":txtfldWeight.text!,
                                       "ethnicity":txtfldEthnicity.text!,
                                       "bust":txtfldBust.text!,
                                       "website":txtfldWebsite.text!,
                                       "page":txtfldPage.text!,
                                       "age":txtfldAge.text!,
                                       "requirment":"Test",
                                       "price":txtfldPrivatePrice.text!
        ]
        
        if UserDefaults.standard.object(forKey:"model") as? String == "As Model"{
            self.lc_ModelFilterHeight.constant = 252
            self.view.updateConstraintsIfNeeded()
        }
        else{
            self.lc_ModelFilterHeight.constant = 0
            self.view.updateConstraintsIfNeeded()
        }
        print(parameters)
        objEditVM.callAddEditProfile(viewController: self, parameters: parameters as NSDictionary, imageData:imgEditProfile.image) { responseObject in
      
            if UserDefaults.standard.object(forKey:"professional") as? String == "As Professional"{
                UserDefaults.standard.set(true, forKey:"autoLogin")
                appDel.setRootViewController()
            }
            else{
                 UserDefaults.standard.set(false, forKey:"autoLogin")
                appDel.goToPhotographerViewController()
            }
        }
    }
    
    
    @IBAction func btnMethodState(_ sender: Any) {
        //  let values = ["Alabama", "Alaska", "Arizona", "Arkansas", "California"]
        DPPickerManager.shared.showPicker(title: "STATE", selected: "", strings: (self.jsonState.allKeys as Any as? [String])!) { (value, index, cancel) in
            if !cancel {
                // TODO: you code here
                self.state = value
                debugPrint(value as Any)
                self.btnState.setTitle(value, for: .normal)
            }
        }
    }
    
    
    @IBAction func btnMethodCity(_ sender: Any) {
        guard  (self.btnState != nil)else{
             CommenMethod.showKSAlertMessage(title:"" , message: "please select state", view: self) {}
            return
        }
       
        for selectCity in jsonState.allKeys{
            if selectCity as? String == self.state {
                let values = jsonState.value(forKey:selectCity as! String)
                
                DPPickerManager.shared.showPicker(title: "CITY", selected: "", strings: (jsonState.value(forKey:selectCity as! String) as! [String])) { (value, index, cancel) in
                    if !cancel {
                        // TODO: you code here
                        debugPrint(value as Any)
                        debugPrint(self.state as Any)
                        self.city = value
                        self.btnCity.setTitle(value, for: .normal)
                    }
                }
            }
        }
    }
    
    
    @IBAction func btnMethodMale(_ sender: Any) {
        btnMale.setImage(UIImage(named: "male.png"), for: UIControlState.normal)
        btnFemale.setImage(UIImage(named: "female.png"), for: UIControlState.normal)
        strGender = "Male"
    }
    
    
    @IBAction func btnMethdFemale(_ sender: Any) {
        btnMale.setImage(UIImage(named: "female.png"), for: UIControlState.normal)
        btnFemale.setImage(UIImage(named: "male.png"), for: UIControlState.normal)
        strGender = "Female" 
    }
    
    
    func datePickerTapped() {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = -3
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        let datePicker = DatePickerDialog(textColor: .red,
                                          buttonColor: .red,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        datePicker.show("DatePickerDialog",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
                            if let dt = date {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "MM/dd/yyyy"
                                self.textFieldAge.text = formatter.string(from: dt)
                            }
        }
    }
}


extension EditProfileVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.textFieldAge {
            datePickerTapped()
            return false
        }
        return true
    }
}
