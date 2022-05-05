//
//  AppDelegate.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let module = RepoListModule()
        let appWindow = UIWindow()
        appWindow.rootViewController = module.getView()
        window = appWindow
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

}

