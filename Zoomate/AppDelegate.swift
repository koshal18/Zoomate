//
//  AppDelegate.swift
//  Zoomate
//
//  Created by Koshal Saini on 27/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import IQKeyboardManagerSwift
import FAPanels
import FBSDKLoginKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard()
    var locationManager:CLLocationManager!
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.determineMyCurrentLocation()
        storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        IQKeyboardManager.shared.enable = true
        self.registerForPushNotifications()
        AutologIn()
        
        FBSDKApplicationDelegate.sharedInstance().application(application,didFinishLaunchingWithOptions:launchOptions)
        return true
    }
    
    /**
     @description - This method will used for get User Current Location.
     @parameter - nil
     @return - nil
     */
    
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        KSSessionManager.sharedInstance.lat = String(format: "%f", userLocation.coordinate.latitude)
        KSSessionManager.sharedInstance.lang = String(format: "%f", userLocation.coordinate.longitude)
        locationManager.stopUpdatingLocation()
    }
    
    private func application(application: UIApplication, openURL url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL?, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        // Add any custom logic here.
        return handled
    }

    
    func AutologIn(){
        //  autoLogin
        if UserDefaults.standard.object(forKey:"autoLogin") as? Bool == true {
            setRootViewController()
        }else if UserDefaults.standard.object(forKey:"autoLogin") as? Bool == false{
            goToPhotographerViewController()
        }
        else{
            goToLoginViewController()
        }
    }
    
    
    // MARK -
    // MARK - Custom Method
    func goToLoginViewController() {
        let objLogin: LaunchScreenViewController = self.storyboard.instantiateViewController(withIdentifier: "LaunchScreenViewController") as! LaunchScreenViewController
        let navController: UINavigationController? = self.storyboard.instantiateViewController(withIdentifier: "navigation") as? UINavigationController
        navController?.viewControllers = [objLogin]
        self.window?.rootViewController = navController
    }
    
    func goToSocialMediaViewController() {
        let objLogin: SocicalMediaVC = self.storyboard.instantiateViewController(withIdentifier: "SocicalMediaVC") as! SocicalMediaVC
        let navController: UINavigationController? = self.storyboard.instantiateViewController(withIdentifier: "navigation") as? UINavigationController
        navController?.viewControllers = [objLogin]
        self.window?.rootViewController = navController
    }
    
    
    func goToPhotographerViewController() {

        let navController: UINavigationController? = self.storyboard.instantiateViewController(withIdentifier: "navigation") as? UINavigationController
        let centerVC = self.storyboard.instantiateViewController(withIdentifier: "PhotographerNearMeVC") as! PhotographerNearMeVC
        let leftMenuVC: LeftMenuVC = self.storyboard.instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuVC
        navController?.setViewControllers([centerVC], animated: false)
        let rootController: FAPanelController = FAPanelController()
        rootController.configs.bounceOnRightPanelOpen = false
        _ = rootController.center(navController!).left(leftMenuVC).right(nil)
        window?.rootViewController = rootController
    }
    
    
    func setRootViewController() {
        let navController: UINavigationController? = self.storyboard.instantiateViewController(withIdentifier: "navigation") as? UINavigationController
        let centerVC = self.storyboard.instantiateViewController(withIdentifier: "PhotographerNearMeVC") as! PhotographerNearMeVC
        let leftMenuVC: LeftMenuVC = self.storyboard.instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuVC
        navController?.setViewControllers([centerVC], animated: false)
        let rootController: FAPanelController = FAPanelController()
        rootController.configs.bounceOnRightPanelOpen = false
        _ = rootController.center(navController!).left(leftMenuVC).right(nil)
        window?.rootViewController = rootController
    }
    
    
    func setHireRootViewController() {
        let navController: UINavigationController? = self.storyboard.instantiateViewController(withIdentifier: "navigation") as? UINavigationController
        let centerVC = self.storyboard.instantiateViewController(withIdentifier: "PhotographerNearMeVC") as! PhotographerNearMeVC
        let leftMenuVC: LeftMenuVC = self.storyboard.instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuVC
        navController?.setViewControllers([centerVC], animated: false)
        let rootController: FAPanelController = FAPanelController()
        rootController.configs.bounceOnRightPanelOpen = false
        _ = rootController.center(navController!).left(leftMenuVC).right(nil)
        window?.rootViewController = rootController
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    
    // MARK: -
    // MARK: - APNS Notification Method
    /**
     @description: This method will used for register push notification.
     @parameter: Nil
     @returns:Nil
     */
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    /**
     @description: This method will used for register push notification with device token.
     @parameter: (_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
     @returns:Nil
     */
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        UserDefaults.standard.setValue(token, forKey: "deviceToken")
        UserDefaults.standard.synchronize()
        KSSessionManager.sharedInstance.deviceToken = token
    }
    
    
    /**
     ! This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
     
     This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases, and which will not be invoked if this method is implemented. !
     */
    
    func application(_ application: UIApplication,didReceiveRemoteNotification userInfo: [AnyHashable : Any],fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void){
        completionHandler(.newData)
    }
    
    
    /**
     @description: This method will used for get push notification error.
     @parameter: (_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
     @returns:Nil
     */
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    /**
     @description: This method will used for get push notification settings.
     @parameter: Nil
     @returns:Nil
     */
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    // MARK: -
    // MARK: - Core Data stack
    /**
     @description: This method will create core data.
     @parameter: (name: "GirasolPayments_iWallet")
     @returns:Nil
     */
    lazy var persistentContainer: NSPersistentContainer = {
        /**
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ZoomateCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /**
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: -
    // MARK: - Core Data Saving support
    /**
     @description: This method will used for core data saving support.
     @parameter: Nil
     @returns:Nil
     */
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

