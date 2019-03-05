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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Instance Properties

    var window: UIWindow?

    // MARK: - Instance Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.setupProject()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
    
    // MARK: - Remote notifications

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.saveRemoteNotificationTokenData(application, deviceToken: deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Log("Failed to register: \(error)")
    }

    func requestForRemoteNotifications () {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { [weak self] granted, error in
            Log("Permission granted: \(granted)")

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

        Log("Device token: \(token)")
        
        UserDefaults.standard.set(deviceToken, forKey: FSUserDefaultsKey.DeviceToken.Data)
        UserDefaults.standard.set(token, forKey: FSUserDefaultsKey.DeviceToken.String)
        UserDefaults.standard.synchronize()
    }

    private func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { settings in
            Log("Notification settings: \(settings)")

            guard settings.authorizationStatus == .authorized else {
                return
            }

            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        })
    }
}
