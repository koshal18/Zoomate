//
//  CommenMethod.swift
//  Zoomate
//
//  Created by Koshal Saini on 28/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import SystemConfiguration

class CommenMethod: NSObject {

    /**
     @description - This Method will be used for navigate view controller.
     @parameter - (storyboard:UIStoryboard, identifier:String, navigation:UINavigationController)
     @return - nil
    */
    class func goToViewController(identifier:String,storyboard:UIStoryboard, navigation:UINavigationController) {
        let objVC = storyboard.instantiateViewController(withIdentifier: identifier)
        navigation.pushViewController(objVC, animated: true)
    }
    
    /**
     @description: This method will be used for validate Email.
     @parameter: (email:String)
     @returns: emailTest.evaluate(with: email)
     */
    //  MARK:-
    //  MARK:-  Check Internet Connection
    class func isValidEmail(email:String)->Bool  {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    /**
     @description: This method will be used for Check Internet Connection.
     @parameter: Nil
     @returns:Bool value
     */
    //  MARK:-
    //  MARK:-  Check Internet Connection
    class func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }

    
    //  The converted code is limited to 1 KB.
    //  Please Sign Up (Free!) to remove this limitation.
    //
    //  Converted to Swift 4 by Swiftify v4.1.6809 - https://objectivec2swift.com/
    func getCountryCodeDictionary() -> [AnyHashable : Any]? {
        return [
            "IL" : "972",
            "AF" : "93",
            "AL" : "355",
            "DZ" : "213",
            "AS" : "1",
            "AD" : "376",
            "AO" : "244",
            "AI" : "1",
            "AG" : "1",
            "AR" : "54",
            "AM" : "374",
            "AW" : "297",
            "AU" : "61",
            "AT" : "43",
            "AZ" : "994",
            "BS" : "1",
            "BH" : "973",
            "BD" : "880",
            "BB" : "1",
            "BY" : "375",
            "BE" : "32",
            "BZ" : "501",
            "BJ" : "229",
            "BM" : "1",
            "BT" : "975",
            "BA" : "387",
            "BW" : "267",
            "BR" : "55",
            "IO" : "246",
            "BG" : "359",
            "BF" : "226",
            "BI" : "257",
            "KH" : "855",
            "CM" : "237",
            "CA" : "1",
            "CV" : "238",
            "KY" : "345",
            "CF" : "236",
            "TD" : "235",
            "CL" : "56",
            "CN" : "86",
            "CX" : "61",
            "CO" : "57",
            "KM" : "269",
            "CG" : "242"]
    }
        //
        //  The converted code is limited to 1 KB.
        //  Please Sign Up (Free!) to remove this limitation.
        //
        //  %< ----------------------------------------------------------------------------------------- %<

    
    /**
     @description: Method used for show alert message
     @parameters:  (title: String, message: String, view: UIViewController)
     @returns:Nil
     */
    class func showKSAlertMessage(title: String, message: String, view: UIViewController, completion: @escaping () -> Void) {
        let objAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Create and an option action
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            completion()
        }
        objAlert.addAction(okAction)
        view.present(objAlert, animated: true, completion: nil)
    }

    
    /**
     @description: Method used for show alert message with ok action
     @parameters:  (title: String, message: String, view: UIViewController)
     @returns:Nil
     */
    class func showAlertMessageWithOkAction(title: String, message: String, view: UIViewController, completion: @escaping () -> Void) {
        let objAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Create and an option action
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            completion()
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .default) { action -> Void in
        }
        objAlert.addAction(okAction)
        objAlert.addAction(cancelAction)
        view.present(objAlert, animated: true, completion: nil)
    }
    
    class func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
