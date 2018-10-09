//
//  WriteReviewVC.swift
//  Zoomate
//
//  Created by Developer on 18/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class WriteReviewVC: UIViewController {
    
    var str_ID = String()
    
    
    @IBOutlet weak var txt_PublicReview: UITextView!
    @IBOutlet weak var OverAllRating: FloatRatingView!
    @IBOutlet weak var str_Accuracy: FloatRatingView!
    @IBOutlet weak var str_Professionalism: FloatRatingView!
    @IBOutlet weak var star_Communication: FloatRatingView!
    @IBOutlet weak var btnRecommendedYes: UIButton!
    @IBOutlet weak var btnRecommendedNo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: -
    // MARK: - Call WebService
    func callAddUserReviews() {
        let param = ["to_id":str_ID,
                     "from_id":UserDefaults.standard.value(forKey: "user_id") ?? "",
                     "Public_review":self.txt_PublicReview.text!,
                     "Overall": String(format: "%f", OverAllRating.rating),
                     "Communication":String(format: "%f", star_Communication.rating),
                     "Professionalism":String(format: "%f", str_Professionalism.rating),
                     "Accuracy":String(format: "%f", str_Accuracy.rating)]
        
        PhotographerFilterVM.callAddUserReviews(viewController: self, parameters: param as NSDictionary) { responseObject in
            CommenMethod.showKSAlertMessage(title: "Zoomate", message: responseObject.message!, view: self, completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    // MARK: - UIButton Action
    @IBAction func tapSubmitButton(_ sender: Any) {
        self.callAddUserReviews()
    }
    
    @IBAction func btnMethodBack(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
    
    @IBAction func btnMethodYes(_ sender: Any) {
        btnRecommendedYes.setImage(UIImage(named: "male.png"), for: UIControlState.normal)
        btnRecommendedNo.setImage(UIImage(named: "female.png"), for: UIControlState.normal)
    }
    
    
    @IBAction func btnMethodNo(_ sender: Any) {
        btnRecommendedYes.setImage(UIImage(named: "female.png"), for: UIControlState.normal)
        btnRecommendedNo.setImage(UIImage(named: "male.png"), for: UIControlState.normal)
    }
}
