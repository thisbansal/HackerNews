//
//  CustomTabBarController.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 9/6/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Tab bar tag: \(item.tag)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor               = .white
        self.tabBar.barTintColor            = .orange
        self.tabBar.unselectedItemTintColor = .black
        
        let layout               = UICollectionViewFlowLayout()
        
        let newsViewController   = ViewController(collectionViewLayout: layout)
        let askViewController    = AskViewController(collectionViewLayout: layout)
        let showViewController   = ShowViewController(collectionViewLayout: layout)
        let jobsViewController   = JobsViewController(collectionViewLayout: layout)
        self.viewControllers     = [ createViewControllers(title: "News", tagName: 0, viewController: newsViewController),
                                     createViewControllers(title: "Ask", tagName: 1, viewController: askViewController),
                                     createViewControllers(title: "Show", tagName: 2, viewController: showViewController),
                                     createViewControllers(title: "Jobs", tagName: 3, viewController: jobsViewController)]
    }
    
    
    private func createViewControllers(title: String, tagName: Int, viewController: UICollectionViewController) -> UINavigationController {
        
        let viewController                                   = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem.title                      = title
        viewController.tabBarItem.tag                        = tagName
        return viewController
    }
}
