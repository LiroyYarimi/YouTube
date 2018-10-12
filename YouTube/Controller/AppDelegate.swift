//
//  AppDelegate.swift
//  YouTube
//
//  Created by liroy yarimi on 17.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //do not forget to delete Main Interface (2018-09-17 13:16:41.725058+0300 YouTube[16738:671344] Unknown class _TtC7YouTube14ViewController in Interface Builder file.)


        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let layout = UICollectionViewFlowLayout()//we need this because HomeController inheritance from UICollectionViewController
//        layout.scrollDirection = .horizontal//horizontal scroll
        window?.rootViewController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))//make the ViewController class to be the root
        
        UINavigationBar.appearance().barTintColor = UIColor.rgb(red: 230, green: 32, blue: 31)//change the navigation bar color
        
        //delete the shadow under the navigation bar (the black line)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        //change the status bar color to white. (to make it work we need to create a new line in info.plist. the new line is: "View controller-based status bar appearance". and value is "NO"
        application.statusBarStyle = .lightContent
        
        //change the status bar background color. To do it we create UIView and change his background color
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.rgb(red: 194, green: 31, blue: 31)
        //this is for iphone x
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.rgb(red: 194, green: 31, blue: 31)
        
        
        //add this statusBarBackgroundView to our window at the top
        window?.addSubview(statusBarBackgroundView)
        window?.addConstraintsWithVisualFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        window?.addConstraintsWithVisualFormat(format: "V:|[v0(20)]", views: statusBarBackgroundView)

        return true
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
    }


}

//change the status bar color (safearea)
extension UIApplication {

    //        UIApplication.shared.statusBarView?.backgroundColor = UIColor.green

    //change the status bar safe area
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }

}
