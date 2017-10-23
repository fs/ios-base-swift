//
//  FSE+UIScrollView.swift
//  FSHelpers
//
//  Created by Ildar Zalyalov on 27.07.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import UIKit

public extension UIScrollView{
    
    var fs_contentWidth: CGFloat {
        set (contentWidth) {self.contentSize = CGSize(width: contentWidth, height: self.contentSize.height)}
        get         {return self.contentSize.width}
    }
    
    var fs_contentHeight: CGFloat {
        set (contentHeight) {self.contentSize = CGSize(width: self.contentSize.width, height: contentHeight)}
        get         {return self.contentSize.height}
    }
    
}
