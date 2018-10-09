//
//  GalleryVC.swift
//  Zoomate
//
//  Created by Developer on 14/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SDWebImage

class GalleryVC: UIViewController {
    
    var imagePicker = UIImagePickerController()
    var objProfileModel:ProfileModel?
    var objProfileVM = ProfileVM()
    var objModelEdit:EditProfileModel?
    
    @IBOutlet weak var cv_Gallary: UICollectionView!
    @IBOutlet weak var img_GallaryHeader: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callGetGalleryImagesWS()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapLeftMenuButton(_ sender: Any) {
        panel?.openLeft(animated: true)
    }
    // MARK:-
    // MARK:- Custom Method
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
        let param = ["userId":UserDefaults.standard.value(forKey: "user_id")]
        objProfileVM.callGetGalleryImages(viewController: self, parameters: param as NSDictionary) { responseObject in
            self.objProfileModel = responseObject
            if self.objProfileModel != nil {
                self.img_GallaryHeader.sd_setImage(with: URL(string: (self.objProfileModel?.objImages[0].image)!), completed: nil)
            }
            self.cv_Gallary.reloadData()
        }
    }
}



// MARK:-
// MARK:- UICollectionView DataSource And Delegate Method
extension GalleryVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.objProfileModel != nil {
            return (self.objProfileModel?.objImages.count)!
        }else {
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ksGalleryCell", for: indexPath) as! ProfileCVCell
        
        cell.img_Gallery.sd_setImage(with: URL(string: (self.objProfileModel?.objImages[indexPath.row].image)!), completed: nil)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.img_GallaryHeader.sd_setImage(with: URL(string: (self.objProfileModel?.objImages[indexPath.row].image)!), completed: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width = collectionViewSize.width/5.0 //Display Three elements in a row.
        collectionViewSize.height = collectionViewSize.width
        return collectionViewSize
    }
}


extension GalleryVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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





