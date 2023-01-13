//
//  AppDelegate.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let rootController = storyBoard.instantiateViewController(withIdentifier: MainTabBarViewController.identifier) as!
        MainTabBarViewController
        
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        
        return true
    }


}

