//
//  DifferentUserReviewVC.swift
//  Zoomate
//
//  Created by Developer on 17/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

class DifferentUserReviewVC: UIViewController {
    
    var arr_Reviews = UserReviewsModel()
    
    
    @IBOutlet weak var tblReviews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callGetReviewsList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: -
    // MARK: - Call Web Service
    func callGetReviewsList() {
        let param = ["userId":KSSessionManager.sharedInstance.str_ReviewID,
                     "skill":KSSessionManager.sharedInstance.str_ReviewSkill]
        UserReviewsVM.callGetUserReviewsListWS(viewController: self, parameters: param as NSDictionary) { responseObject in
            self.arr_Reviews = responseObject
            self.tblReviews.reloadData()
        }
    }
}


extension DifferentUserReviewVC:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arr_Reviews.arr_UserReviewList.count > 0 {
            return self.arr_Reviews.arr_UserReviewList.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserReview", for: indexPath) as! UserReview
        cell.selectionStyle = .none
        cell.floatRating.rating = Double(self.arr_Reviews.arr_UserReviewList[indexPath.row].rating!)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
}


class UserReview: UITableViewCell {
    @IBOutlet weak var floatRating: FloatRatingView!
    
}
