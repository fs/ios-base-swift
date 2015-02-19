//
//  AppDelegate.swift
//  Swift-Base
//
//  Created by Kruperfone on 02.10.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//

import UIKit
import CoreData
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        //setting AFNetwork
        /*
        AFNetworkReachabilityManager.sharedManager().startMonitoring()
        AFNetworkActivityIndicatorManager.sharedManager().enabled   = true
        */
        
        //setting SDWebImage
        
        /*
        let imageCache:SDImageCache = SDImageCache.sharedImageCache()
        imageCache.maxCacheSize     = 1024*1024*100 // 100mb on disk
        imageCache.maxMemoryCost    = 1024*1024*10  // 10mb in memory
        
        let imageDownloader:SDWebImageDownloader = SDWebImageDownloader.sharedDownloader()
        imageDownloader.downloadTimeout          = 60.0
        */
        
        //setting Crashlytics
        /*
        if DEBUG == 1
        {
            println("Crashlytics is disabled in DEBUG")
        }
        else
        {
            Crashlytics.startWithAPIKey(kAPIKeyCrashlitycs)
        }
        */
        
        return true
    }

    func applicationWillResignActive(application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication)
    {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
}

