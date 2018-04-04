//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by Jeff Kral on 1/2/18.
//  Copyright © 2018 Jeff Kral. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            present(navController, animated: true, completion: nil)
            
            return false
        } else {
            return true
        }        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        
        setupViewControllers()
    }
        
        func setupViewControllers() {
            
            let homeNavController = templateNavController(selectedImage: #imageLiteral(resourceName: "home_selected"), unselectedImage: #imageLiteral(resourceName: "home_unselected"), rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
            
            let searchNavController = templateNavController(selectedImage: #imageLiteral(resourceName: "search_selected"), unselectedImage: #imageLiteral(resourceName: "search_unselected"), rootViewController: UserSearchController(collectionViewLayout: UICollectionViewFlowLayout())) 
            
            let plusNavController = templateNavController(selectedImage: #imageLiteral(resourceName: "plus_unselected"), unselectedImage: #imageLiteral(resourceName: "plus_unselected"))
            
            let likeNavController = templateNavController(selectedImage: #imageLiteral(resourceName: "like_selected"), unselectedImage: #imageLiteral(resourceName: "like_unselected"))
            
            let layout = UICollectionViewFlowLayout()
            let userProfileController = UserProfileController(collectionViewLayout: layout)
            let userProfileNavController = UINavigationController(rootViewController: userProfileController)
            userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
            userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
            
            tabBar.tintColor = .black
            
            viewControllers = [homeNavController,
                               searchNavController,
                               plusNavController,
                               likeNavController,
                               userProfileNavController]
            
            guard let items = tabBar.items else { return }
            
            for item in items {
                item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
            }
            
        }
    
    fileprivate func templateNavController(selectedImage: UIImage, unselectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let viewController = rootViewController
        let navController =  UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}













