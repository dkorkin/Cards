//
//  AppDelegate.swift
//  TestCards
//
//  Created by Dmitriy Korkin on 21/12/2018.
//  Copyright © 2018 Dmitriy Korkin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let cardsVC = CardsViewController()
        let navigationVC = UINavigationController.init(rootViewController: cardsVC)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationVC
        self.window?.makeKeyAndVisible()
        return true
    }

}

