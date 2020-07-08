//
//  AppDelegate.swift
//  Swift-Base
//
//  Created by FS Flatstack on 02/10/2014.
//  Copyright © 2014 Flatstack. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Instance Properties

    var window: UIWindow?

    // MARK: - Instance Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setupProject()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }

    // MARK: - Remote notifications

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.saveRemoteNotificationTokenData(application, deviceToken: deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) { }

    func requestForRemoteNotifications () {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { [weak self] granted, error in
            guard granted else {
                return
            }

            self?.getNotificationSettings()
        })
    }
}

// MARK: - Settings

extension AppDelegate {

    // MARK: - Instance Methods

    private func setupProject() {
        FirebaseApp.configure()
    }
}

// MARK: - Push notifications

extension AppDelegate {

    // MARK: - Instance Methods

    private func saveRemoteNotificationTokenData(_ application: UIApplication, deviceToken: Data) {
        let tokenParts = deviceToken.map { data in
            String(format: "%02.2hhx", data)
        }

        let token = tokenParts.joined()

        Log.i(token)
    }

    private func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { settings in
            guard settings.authorizationStatus == .authorized else {
                return
            }

            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        })
    }
}
