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
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    func setupViewController() {
        let characterList = addChildViewController(CharacterListViewController(), "Characters", "person", 0)
        let locationView = addChildViewController(LocationViewController(), "Locations", "location.fill", 1)
        let episodesView = addChildViewController(EpisodesViewController(), "Episodes", "doc.fill", 2)
        let settingsView = addChildViewController(SettingsViewController(), "Settings", "gearshape", 3)
        viewControllers = [characterList, locationView, episodesView, settingsView]
    }
    
    func addChildViewController(_ childViewController: UIViewController,_ title: String,_ imageName: String,_ tag: Int) -> UINavigationController {
        let navigationViewController = UINavigationController(rootViewController: childViewController)
        navigationViewController.navigationBar.topItem?.title = title
        let image = UIImage(systemName: imageName)
        let tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        navigationViewController.tabBarItem = tabBarItem
        return navigationViewController
    }
    
}

