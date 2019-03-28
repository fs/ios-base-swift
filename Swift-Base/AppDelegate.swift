//
//  AppDelegate.swift
//  Swift-Base
//
//  Created by Kruperfone on 02.10.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Instance Properties

    var window: UIWindow?

    // MARK: - Instance Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Log.initialize(withDateFormat: "HH:mm:ss.SSSS")
        Log.high("applicationDidFinishLaunchingWithOptions(\(launchOptions ?? [:]))", from: self)
        
        self.setupProject()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        Log.high("applicationWillResignActive()", from: self)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        Log.high("applicationDidEnterBackground()", from: self)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        Log.high("applicationWillEnterForeground()", from: self)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        Log.high("applicationDidBecomeActive()", from: self)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        Log.high("applicationWillTerminate()", from: self)
    }
    
    // MARK: - Remote notifications

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Log.high("applicationDidRegisterForRemoteNotifications()", from: self)
        
        self.saveRemoteNotificationTokenData(application, deviceToken: deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Log.high("applicationDidFailToRegisterForRemoteNotifications(withError: \(error))", from: self)
    }

    func requestForRemoteNotifications () {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { [weak self] granted, error in
            Log.high("Permission granted: \(granted)", from: self)

            guard granted else {
                return
            }

            self?.getNotificationSettings()
        })
    }
}

// MARK: - Settings

private extension AppDelegate {

    // MARK: - Instance Methods
    
    private func setupProject() {
        Fabric.with([Crashlytics.self])
    }

    /*
    Setup third party libraries

    private func setupSDWebImage() {
        let imageCache:SDImageCache = SDImageCache.sharedImageCache()
        imageCache.maxCacheSize     = 1024*1024*100 // 100mb on disk
        imageCache.maxMemoryCost    = 1024*1024*10  // 10mb in memory

        let imageDownloader:SDWebImageDownloader = SDWebImageDownloader.sharedDownloader()
        imageDownloader.downloadTimeout          = 60.0
    }
    */
}

// MARK: - Push notifications

private extension AppDelegate {

    // MARK: - Instance Methods
    
    private func saveRemoteNotificationTokenData(_ application: UIApplication, deviceToken: Data) {
        let tokenParts = deviceToken.map { data in
            String(format: "%02.2hhx", data)
        }

        let token = tokenParts.joined()

        Log.high("Device token: \(token)", from: self)
        
        UserDefaults.standard.set(deviceToken, forKey: UserDefaultsKeys.DeviceToken.data)
        UserDefaults.standard.set(token, forKey: UserDefaultsKeys.DeviceToken.string)
        UserDefaults.standard.synchronize()
    }

    private func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { settings in
            Log.high("Notification settings: \(settings)", from: self)

            guard settings.authorizationStatus == .authorized else {
                return
            }

            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        })
    }
}
