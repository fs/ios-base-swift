//
//  RemoteNotificationDeepLink.swift
//  Swift-Base
//
//  Created by Nikita Asabin on 15.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import UIKit

enum DeepLinkAppSectionKey : Int {
    case example = 0
    
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
        case .example:  return "example";
        }
    }
    
}

enum ArticleType: String {
    case ArticleA = "A"
    case ArticleB = "B"
    case ArticleC = "C"
}


class DeepLink: NSObject {

    class func create(_ userInfo : [AnyHashable: Any], sectionKey: DeepLinkAppSectionKey) -> DeepLink? {
        let info = userInfo as NSDictionary
        
        switch sectionKey {
        case DeepLinkAppSectionKey.example:
            guard let articleID = info.object(forKey: DeepLinkAppSectionKey.example.description) as? String else {return nil}
            
            var deepLink : DeepLink? = nil
            if !articleID.isEmpty
            {
                deepLink = DeepLinkExample(exampleStr: articleID)
            }
            return deepLink
        }
        
    }
    
    fileprivate override init() {
        super.init()
    }
    
    final func trigger() {
        DispatchQueue.main.async {
            self.triggerImp()
                { (passedData) in
        
            }
        }
    }
    
    fileprivate func triggerImp(_ completion: ((AnyObject?)->(Void))) {
        completion(nil)
    }
}

class DeepLinkExample : DeepLink {
    
    let exampleID : String
    
    fileprivate init(exampleStr: String) {
        self.exampleID = exampleStr
        super.init()
    }
    
    fileprivate override func triggerImp(_ completion: ((AnyObject?)->(Void))) {
        super.triggerImp() { (passedData) in
                
                var vc = UIViewController()
                let  storyboard = UIStoryboard.init(name: "Main_Storyboard", bundle: nil)
                // Handle Deep Link Data to present the Article passed through
                
                switch self.exampleID {
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
