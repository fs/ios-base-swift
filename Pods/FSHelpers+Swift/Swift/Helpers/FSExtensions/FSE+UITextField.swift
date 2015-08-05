//
//  FSE+UITextField.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

class FSTextView :UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.setupInsets()
    }
    
     required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupInsets()
    }
    
    private func setupInsets () {
        self.textContainerInset = UIEdgeInsetsMake(-4,0,0,0)
        self.textContainer.lineFragmentPadding = 0
    }
    
    override class func getTextHeight (forText text:String, width:CGFloat, font:UIFont) -> CGFloat {
        let textView = FSTextView(frame: CGRectMake(0, 0, width, 0))
        textView.font = font
        textView.text = text
        return textView.textHeight
    }
    
    override var textHeight:CGFloat {
        return super.textHeight
    }
}

extension UITextView {
    
    class func getTextHeight (forText text:String, width:CGFloat, font:UIFont) -> CGFloat {
        
        let textView = UITextView(frame: CGRectMake(0, 0, width, 0))
        textView.font = font
        textView.text = text
        return textView.textHeight
    }
    
    var textHeight:CGFloat {
        let size = self.sizeThatFits(CGSizeMake(width, CGFloat.max))
        return size.height + 1
    }
}
