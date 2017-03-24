//
//  AppDelegate.swift
//  Swift-Base
//
//  Created by Kruperfone on 02.10.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    fileprivate(set) var loadedEnoughToDeepLink : Bool = false
    fileprivate(set) var deepLink : DeepLink?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if IS_RUNNING_TESTS() {
            self.setupProjectForTests()
        } else {
            self.setupProject()
        }
        
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
    
    //MARK: - Remote notifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.saveRemoteNotificationTokenData(application, deviceToken: deviceToken)
    }
    
    //MARK: - Deeplinks
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return self.canOpenURL(application, url: url)
    }
}

//MARK: - Settings
fileprivate extension AppDelegate {
    
    func setupProject() {
        
        self.shareSetupProject()
        
        //setup Crashlytics
        Fabric.with([Crashlytics.self])
    }
    
    func setupProjectForTests() {
        
        self.shareSetupProject()
        
        #if TEST
            switch TestingMode() {
            case .Unit:
                Log("Unit Tests")
                self.window?.rootViewController = UIViewController()
                return
                
            case .UI:
                Log("UI Tests")
                //setting custom the first view controller
//                self.window?.rootViewController = UIViewController()
            }
        #endif
    }
    
    func shareSetupProject() {
        
        self.printProjectSettings()
        
        //setup AFNetworking
        self.setupAFNetworking()
        
        //setup Magical Record
        //        self.setupMagicalRecord()
        
        //setup SDWebImage
        //        self.setupSDWebImage()
    }
    
    func printProjectSettings() {
        #if DEBUG
            // print documents directory and device ID
            Log("\n*******************************************\nDOCUMENTS:\n\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])\n*******************************************\n")
            Log("\n*******************************************\nDEVICE ID:\n\((UIDevice.current.identifierForVendor?.uuidString)!)\n*******************************************\n")
            Log("\n*******************************************\nBUNDLE ID:\n\((Bundle.main.bundleIdentifier)!)\n*******************************************\n")
        #endif
    }
    
    func setupAFNetworking() {
        AFNetworkReachabilityManager.shared().startMonitoring()
        AFNetworkActivityIndicatorManager.shared().isEnabled   = true
    }
    
//    func setupMagicalRecord() {
//        MagicalRecord.setShouldDeleteStoreOnModelMismatch(true)
//        MagicalRecord.setupAutoMigratingCoreDataStack()
//        MagicalRecord.setLoggingLevel(MagicalRecordLoggingLevel.Off)
//    }
    
//    func setupSDWebImage() {
//        let imageCache:SDImageCache = SDImageCache.sharedImageCache()
//        imageCache.maxCacheSize     = 1024*1024*100 // 100mb on disk
//        imageCache.maxMemoryCost    = 1024*1024*10  // 10mb in memory
//        
//        let imageDownloader:SDWebImageDownloader = SDWebImageDownloader.sharedDownloader()
//        imageDownloader.downloadTimeout          = 60.0
//    }
}

//MARK: - Push notifications 
fileprivate extension AppDelegate {
    
    func saveRemoteNotificationTokenData(_ application: UIApplication, deviceToken: Data) {
        let tokenChars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
        var tokenString = ""
        UIFont.systemFont(ofSize: 1, weight: 1)
        for i in 0 ..< deviceToken.count {
            let formatString = "%02.2hhx"
            tokenString += String(format: formatString, arguments: [tokenChars[i]])
        }
        
        UserDefaults.standard.set(deviceToken, forKey: FSUserDefaultsKey.DeviceToken.Data)
        UserDefaults.standard.set(tokenString, forKey: FSUserDefaultsKey.DeviceToken.String)
        UserDefaults.standard.synchronize()
    }
    
    func requestForRemoteNotifications () {
        UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [UIUserNotificationType.alert, UIUserNotificationType.sound, UIUserNotificationType.badge], categories: nil))
        UIApplication.shared.registerForRemoteNotifications()
    }
}

//MARK: - DeepLink Handling
extension AppDelegate {
    
    fileprivate func canOpenURL(_ application: UIApplication, url: URL) -> Bool {
        if url.host == nil {
            return true;
        }
        
        let urlString = url.absoluteString
        let queryArray = urlString.components(separatedBy: "/")
        let query = queryArray[2]
        
        for sectionKey in DeepLinkAppSectionKey.allValues {
            if query.range(of: sectionKey.description) != nil
            {
                let data = urlString.components(separatedBy: "/")
                if data.count >= 3
                {
                    let parameter = data[3]
                    let userInfo = [sectionKey.description : parameter]
                    self.applicationHandleDeepLink(application, deepLinkUserInfo: userInfo, sectionKey: sectionKey)
                    break
                }
            }
        }
        return true
    }
    
    fileprivate func applicationHandleDeepLink(_ application: UIApplication,
                                   deepLinkUserInfo userInfo: [AnyHashable: Any],
                                   sectionKey: DeepLinkAppSectionKey) {
        if  application.applicationState == UIApplicationState.background ||
            application.applicationState == UIApplicationState.inactive {
            let canDoNow = loadedEnoughToDeepLink
            
            self.deepLink = DeepLink.create(userInfo,sectionKey: sectionKey)
            
            if canDoNow {
                self.triggerDeepLinkIfPresent()
            }
        }
    }
    
    func triggerDeepLinkIfPresent() {
        self.loadedEnoughToDeepLink = true
        self.deepLink?.trigger()
        self.deepLink = nil
    }
}
