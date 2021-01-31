//
//  AppDelegate.swift
//  marvel-characters
//
//  Created by Matheus Brasilio on 28/01/21.
//  Copyright © 2021 Matheus Brasilio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 0.5)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = self.window {
            let nav = UINavigationController()
            let vc = CharactersListViewController()
            nav.viewControllers = [vc]
            nav.navigationBar.isTranslucent = false
            nav.navigationBar.tintColor = UIColor.white
            nav.navigationBar.barTintColor = UIColor.black
            nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            nav.navigationBar.barStyle = .black
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
        return true
    }
}
