//
//  MainNavigationViewController.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/27.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func showDetailViewController(_ vc: UIViewController, sender: Any?) {
        vc.hidesBottomBarWhenPushed = true
        super.showDetailViewController(vc, sender: sender)
    }
    
    
}
