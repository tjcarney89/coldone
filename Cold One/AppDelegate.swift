//
//  AppDelegate.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let navigationBarAppearance = UINavigationBar.appearance()
    let segmentedControlAppearance = UISegmentedControl.appearance()
    let attributes1 = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "BEER", size: 24)]
    let font2 = [NSFontAttributeName: UIFont(name: "BEER", size: 15)]


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        navigationBarAppearance.titleTextAttributes = attributes1
        navigationBarAppearance.barTintColor = UIColor(red: 225/255, green: 214/255, blue: 15/255, alpha: 1.0)
        //(red: 225, green: 214, blue: 15, alpha: 1.0)
        segmentedControlAppearance.setTitleTextAttributes(font2, for: .normal)
        //segmentedControlAppearance.backgroundColor = UIColor(red: 87/255, green: 46/255, blue: 11/255, alpha: 1.0)
        // Override point for customization after application launch.
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

