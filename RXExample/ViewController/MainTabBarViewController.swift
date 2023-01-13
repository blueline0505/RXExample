//
//  ViewController.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/26.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    static let identifier = "MainTabBarViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        setupViewController()
        setupNavigationBar()
    }
    
    func setTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .fillVintage
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        UITabBar.appearance().tintColor = .white // change icon and title color
        UITabBar.appearance().unselectedItemTintColor = .fillGray // background default color
    }
    
    func setupNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .fillVintage
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    func setupViewController() {
        let rmCharacter = addChildViewController(initViewController(RMCharacterViewController.identifier),
                                                 "Characters", "person", 0)
        let rmLocation = addChildViewController(initViewController(RMLocationViewController.identifier),
                                                "Locations", "location.fill", 1)
        let rmEpisodes = addChildViewController(initViewController(RMEpisodesViewController.identifier),
                                                "Episodes", "doc.fill", 2)
        let rmSettings = addChildViewController(initViewController(RMSettingsViewController.identifier),
                                                "Settings", "gearshape", 3)
        viewControllers = [rmCharacter, rmLocation, rmEpisodes, rmSettings]
    }
    
    func initViewController(_ named: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: named)
        return viewController
    }
    
    func addChildViewController(_ childViewController: UIViewController,_ title: String,_ imageName: String,_ tag: Int) -> UINavigationController {
        let navigationViewController = MainNavigationController(rootViewController: childViewController)
        navigationViewController.navigationBar.topItem?.title = title
        let image = UIImage(systemName: imageName)
        let tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        navigationViewController.tabBarItem = tabBarItem
        return navigationViewController
    }
}

