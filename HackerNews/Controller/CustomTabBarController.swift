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
        
//        self.tabBar.isTranslucent           = true
        self.tabBar.barStyle                = .black

        self.tabBar.tintColor               = Color.progressViewTintColor.value
        self.tabBar.unselectedItemTintColor = Color.lightBackground.value
        
        let layoutForNewsVC                = UICollectionViewFlowLayout()
        layoutForNewsVC.minimumLineSpacing = 2
        
        let layoutForAskVC                 = UICollectionViewFlowLayout()
        layoutForAskVC.minimumLineSpacing  = 2
        
        let layoutForShowVC                = UICollectionViewFlowLayout()
        layoutForShowVC.minimumLineSpacing  = 2
        
        let layoutForJobsVC                = UICollectionViewFlowLayout()
        layoutForJobsVC.minimumLineSpacing  = 2
        
        
        let newsViewController   = ViewController(collectionViewLayout: layoutForNewsVC)
        let askViewController    = AskViewController(collectionViewLayout: layoutForAskVC)
        let showViewController   = ShowViewController(collectionViewLayout: layoutForShowVC)
        let jobsViewController   = JobsViewController(collectionViewLayout: layoutForJobsVC)
        
        self.viewControllers     = [ createViewControllers(title: "News", tagName: 0, imageName: "news", viewController: newsViewController),
                                     createViewControllers(title: "Ask",  tagName: 1, imageName: "ask",  viewController: askViewController),
                                     createViewControllers(title: "Show", tagName: 2, imageName: "show", viewController: showViewController),
                                     createViewControllers(title: "Jobs", tagName: 3, imageName: "job",  viewController: jobsViewController)]
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
