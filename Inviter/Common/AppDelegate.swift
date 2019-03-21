//
//  AppDelegate.swift
//  Inviter
//
//  Created by lucas.cardinali on 3/19/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let invitedViewController = InvitedViewController()
        let navController = UINavigationController(rootViewController: invitedViewController)
        navController.navigationBar.prefersLargeTitles = true

        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }

}
