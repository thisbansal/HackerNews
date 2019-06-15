//
//  CustomTabBarController.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 9/6/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent           = true
        self.tabBar.barStyle                = .black
        
        self.tabBarItem.titleTextAttributes(for: .highlighted)
        
        let layoutforNewsVC               = UICollectionViewFlowLayout()
        let layoutforAskVC                = UICollectionViewFlowLayout()
        let layoutforShowVC               = UICollectionViewFlowLayout()
        let layoutforJobsVC               = UICollectionViewFlowLayout()
        
        
        let newsViewController   = ViewController(collectionViewLayout: layoutforNewsVC)
        let askViewController    = AskViewController(collectionViewLayout: layoutforAskVC)
        let showViewController   = ShowViewController(collectionViewLayout: layoutforShowVC)
        let jobsViewController   = JobsViewController(collectionViewLayout: layoutforJobsVC)
        
        self.viewControllers     = [ createViewControllers(title: "News", tagName: 0, imageName: "news", viewController:        newsViewController),
                                     createViewControllers(title: "Ask",  tagName: 1, imageName: "ask", viewController: askViewController),
                                     createViewControllers(title: "Show", tagName: 2, imageName: "show", viewController: showViewController),
                                     createViewControllers(title: "Jobs", tagName: 3, imageName: "job", viewController: jobsViewController)]
    }
    
    private func createViewControllers(title: String, tagName: Int, imageName: String, viewController: UICollectionViewController) -> UINavigationController {
        let navigationViewController                                   = UINavigationController(rootViewController: viewController)
        navigationViewController.tabBarItem.title                      = title
        navigationViewController.tabBarItem.tag                        = tagName
        navigationViewController.navigationBar.barStyle                = .blackTranslucent
        navigationViewController.tabBarItem.image                      = UIImage(named: imageName)
        return navigationViewController
    }
}
