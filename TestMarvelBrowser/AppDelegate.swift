//
//  AppDelegate.swift
//  TestMarvelMonolithic
//
//  Created by David Vallejo on 24/5/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy var navigationController: UINavigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else {
            return false
        }
        
        navigationController.viewControllers = [SplashViewController()]
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return true
    }
}

