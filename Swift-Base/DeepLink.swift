//
//  RemoteNotificationDeepLink.swift
//  Swift-Base
//
//  Created by Nikita Asabin on 15.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import UIKit

enum  DeepLinkAppSectionKey : Int{
    case Article = 0
    
    static var allValues: [DeepLinkAppSectionKey] {
        var sectionKeys: [DeepLinkAppSectionKey] = []
        var i = 0
        while let key = DeepLinkAppSectionKey(rawValue: i) {
            sectionKeys.append(key)
            i += 1
        }
        return sectionKeys
    }
    
    var description : String {
        switch self {
        case .Article:  return "article";
        }
    }
    
}

enum ArticleType: String {
        case ArticleA = "A"
        case ArticleB = "B"
        case ArticleC = "C"
}


class DeepLink: NSObject {
    
    var sectionKey:DeepLinkAppSectionKey?
    
    class func create(userInfo : [NSObject : AnyObject], sectionKey:DeepLinkAppSectionKey) -> DeepLink?
    {
        let info = userInfo as NSDictionary
        
        switch sectionKey {
        case DeepLinkAppSectionKey.Article:
            
            guard let articleID = info.objectForKey(DeepLinkAppSectionKey.Article.description) as? String else {return nil}
            
            var deepLink : DeepLink? = nil
            if !articleID.isEmpty
            {
                deepLink = DeepLinkArticle(articleStr: articleID)
            }
            return deepLink

        default:
            return nil
        }
        
    }
    
    private override init()
    {
        super.init()
    }
    
    final func trigger()
    {
        dispatch_async(dispatch_get_main_queue())
        {
            self.triggerImp()
                { (passedData) in
        
            }
        }
    }
    
    private func triggerImp(completion: ((AnyObject?)->(Void)))
    {
        completion(nil)
    }
}

class DeepLinkArticle : DeepLink
{
    var articleID : String!
    
    private init(articleStr: String)
    {
        self.articleID = articleStr
        super.init()
    }
    
    private override func triggerImp(completion: ((AnyObject?)->(Void)))
    {
        super.triggerImp()
            { (passedData) in
                
                var vc = UIViewController()
                let  storyboard = UIStoryboard.init(name: "Main_Storyboard", bundle: nil)
                // Handle Deep Link Data to present the Article passed through
                
                switch self.articleID {
                case ArticleType.ArticleA.rawValue :
                    vc = storyboard.instantiateViewControllerWithIdentifier("ViewControllerA")
                    break
                case ArticleType.ArticleB.rawValue :
                    vc = storyboard.instantiateViewControllerWithIdentifier("ViewControllerB")
                    break
                case ArticleType.ArticleC.rawValue :
                    vc = storyboard.instantiateViewControllerWithIdentifier("ViewControllerC")
                    break
                default: break
                }
                
                guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {completion(nil); return}
                appDelegate.window?.addSubview(vc.view)
                
                completion(nil)
        }
    }
    
}
