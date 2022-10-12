//
//  TabBarController.swift
//  UseCase
//
//  Created by Rodrigo Souza on 08/10/22.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        // Do any additional setup after loading the view.
        UITabBar.appearance().barTintColor = .systemRed
        tabBar.tintColor = .red
        tabBar.backgroundColor = .cyan
        
        
        setupViewControllers()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func setupViewControllers() {
        viewControllers = [
            createNavController(for: HelloViewController(),
                                title: NSLocalizedString("Search", comment: ""),
                                image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: HelloViewController(),
                                title: NSLocalizedString("Home", comment: ""),
                                image: UIImage(systemName: "house")!),
            createNavController(for: HelloViewController(),
                                title: NSLocalizedString("Profile", comment: ""),
                                image: UIImage(systemName: "person")!)
        ]
    }
    
    
    func createNavController(for rootViewController: UIViewController,
                             title: String,
                             image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
}
