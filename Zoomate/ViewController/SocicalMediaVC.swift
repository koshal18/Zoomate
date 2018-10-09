//
//  SocicalMediaVC.swift
//  Zoomate
//
//  Created by Koshal Saini on 28/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKMessengerShareKit
class SocicalMediaVC: UIViewController,FBSDKLoginButtonDelegate {

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
    /*
     @description - This method will used for move on SignUp Screen.
     @parameter - (_ sender: Any)
     @return - nil
     */
    @IBAction func tapSignUpButton(_ sender: Any) {
        CommenMethod.goToViewController(identifier: "SignUpVC", storyboard: self.storyboard!, navigation: self.navigationController!)
    }
    
    /*
     @description - This method will used for move on SignIn Screen.
     @parameter - (_ sender: Any)
     @return - nil
     */
    @IBAction func tapSignInButton(_ sender: Any) {
        CommenMethod.goToViewController(identifier: "LoginVC", storyboard: self.storyboard!, navigation: self.navigationController!)
    }
    
    
    /*
     @description - This method will used for login with Facebook.
     @parameter - (_ sender: Any)
     @return - nil
     */
    @IBAction func tapFacebookButton(_ sender: Any) {
        if FBSDKAccessToken.current() != nil {
            fetchProfile()
        } else {
            
            let loginManager = FBSDKLoginManager()
            loginManager.logIn(withReadPermissions: ["email","public_profile","user_friends"], from: self, handler: { (loginResults: FBSDKLoginManagerLoginResult?, error: Error?) -> Void in
                
                if !(loginResults?.isCancelled)! {
                    self.fetchProfile()
                } else {    // Sign in request cancelled
                    let err = NSError()
                    // handle error object
                }
            })
        }
    }
    
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, picture.type(large)"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    print(result!)
                }
            })
        }
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
        } else {
            fetchProfile()
        }
    }
    
    
    func fetchProfile() {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, picture.type(large)"]).start{ (connection,result,error)-> Void in
            if error != nil {   // Error occured while logging in
                // handle error
                print(error!)
                return
            }
            // Details received successfully
            let dictionary = result as! [String: AnyObject]
            print(dictionary)
            // pass this dictionary object into your model class initialiser
        }
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
    }

    
    /*
     @description - This method will used for login with Twitter.
     @parameter - (_ sender: Any)
     @return - nil
     */
    @IBAction func tapTwitterButton(_ sender: Any) {
        
    }
}
