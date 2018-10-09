//
//  LaunchScreenViewController.swift
//  LaunchAnimation
//
//  Created by Nanostuffs Technologoies Pvt. Ltd. on 20/09/17.
//  Copyright © 2017 Nanostuffs Technologoies Pvt. Ltd. All rights reserved.
//  //https://www.youtube.com/watch?v=Z_2HONmrR5Q

import UIKit
import SwiftGifOrigin

class LaunchScreenViewController: UIViewController {
    var timer = Timer()

    @IBOutlet weak var launchImgVw: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //launchImgVw.loadGif(name: "zoom-gif")
        
//        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "zoom-gif", withExtension: "gif")!)
//        let advTimeGif = UIImage.gifImageWithData(imageData!)
//        launchImgVw.image = advTimeGif
      
        let jeremyGif = UIImage.gif(name: "LaunchImage")
        
        launchImgVw.image = jeremyGif

        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.goToMainScreen), userInfo: nil, repeats: true)
    }
    
    @objc func goToMainScreen() {
        
        timer.invalidate()
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SocicalMediaVC")

        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
