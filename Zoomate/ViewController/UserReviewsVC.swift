
//
//  UserReviewsVC.swift
//  Zoomate
//
//  Created by Developer on 17/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import CarbonKit
class UserReviewsVC: UIViewController,CarbonTabSwipeNavigationDelegate {

    var str_ID = String()
    var tabSwipe:CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    let arr_Items = [ "All", "Photographer", "Model"]
    
    @IBOutlet weak var viewReview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KSSessionManager.sharedInstance.str_ReviewID = self.str_ID
        
        tabSwipe = CarbonTabSwipeNavigation(items:arr_Items , delegate: self)
        tabSwipe.insert(intoRootViewController:self, andTargetView: viewReview)
        tabSwipe.navigationController?.navigationBar.isHidden = false
        setStyle()
    }
    
    /**
     @description: This method will used for set style of carbon kit.
     @parameter: nil
     @returns:nil
     */
    func setStyle() {
        tabSwipe.toolbar.isTranslucent = false
        tabSwipe.toolbar.barTintColor = UIColor.clear
        tabSwipe.toolbar.tintColor = .clear
        tabSwipe.toolbar.backgroundColor = .clear
        tabSwipe.setIndicatorColor(#colorLiteral(red: 0.231272012, green: 0.6793185472, blue: 0.8793970942, alpha: 1))
        tabSwipe.setIndicatorHeight(2)
        tabSwipe.setSelectedColor(#colorLiteral(red: 0.231272012, green: 0.6793185472, blue: 0.8793970942, alpha: 1))
        tabSwipe.setNormalColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        tabSwipe.toolbarHeight.constant = CGFloat(40)
        tabSwipe.toolbar.setBackgroundImage(#imageLiteral(resourceName: "white"), forToolbarPosition: .any, barMetrics: .default)
        let intCount = arr_Items.count
        for i in 0..<intCount {
            tabSwipe.carbonSegmentedControl?.setWidth(view.frame.width/CGFloat(intCount), forSegmentAt: i)
        }
    }
    
    @IBAction func btnMethodBack(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func tapReviewButton(_ sender: Any) {
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "WriteReviewVC") as! WriteReviewVC
        objVC.str_ID = self.str_ID
        self.navigationController?.pushViewController(objVC, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        if index == 1 {
            KSSessionManager.sharedInstance.str_ReviewSkill = "Photographer"
        }
        else if index == 2 {
            KSSessionManager.sharedInstance.str_ReviewSkill = "Model"
        }else {
            KSSessionManager.sharedInstance.str_ReviewSkill = "Photographer"
        }
        return storyboard!.instantiateViewController(withIdentifier: "DifferentUserReviewVC")
    }
}
