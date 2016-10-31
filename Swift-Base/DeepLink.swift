//
//  RemoteNotificationDeepLink.swift
//  Swift-Base
//
//  Created by Nikita Asabin on 15.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import UIKit

enum  DeepLinkAppSectionKey : Int{
    case article = 0
    
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
        case .article:  return "article";
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
    
    class func create(_ userInfo : [AnyHashable: Any], sectionKey:DeepLinkAppSectionKey) -> DeepLink?
    {
        let info = userInfo as NSDictionary
        
        switch sectionKey {
        case DeepLinkAppSectionKey.article:
            
            guard let articleID = info.object(forKey: DeepLinkAppSectionKey.article.description) as? String else {return nil}
            
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
    
    fileprivate override init()
    {
        super.init()
    }
    
    final func trigger()
    {
        DispatchQueue.main.async
        {
            self.triggerImp()
                { (passedData) in
        
            }
        }
    }
    
    fileprivate func triggerImp(_ completion: ((AnyObject?)->(Void)))
    {
        completion(nil)
    }
}

class DeepLinkArticle : DeepLink
{
    var articleID : String!
    
    fileprivate init(articleStr: String)
    {
        self.articleID = articleStr
        super.init()
    }
    
    fileprivate override func triggerImp(_ completion: ((AnyObject?)->(Void)))
    {
        super.triggerImp()
            { (passedData) in
                
                var vc = UIViewController()
                let  storyboard = UIStoryboard.init(name: "Main_Storyboard", bundle: nil)
                // Handle Deep Link Data to present the Article passed through
                
                switch self.articleID {
                case ArticleType.ArticleA.rawValue :
                    vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerA")
                    break
                case ArticleType.ArticleB.rawValue :
                    vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerB")
                    break
                case ArticleType.ArticleC.rawValue :
                    vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerC")
                    break
                default: break
                }
                
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {completion(nil); return}
                appDelegate.window?.addSubview(vc.view)
                
                completion(nil)
        }
    }
    
}
