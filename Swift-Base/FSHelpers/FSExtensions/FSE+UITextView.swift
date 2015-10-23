//
//  FSE+UITextField.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

class FSTextView :UITextView {
    
    private(set) var placeholderLabel:UILabel = UILabel()
    
    @IBInspectable var placeholderColor:UIColor {
        set (value) {
            self.placeholderLabel.textColor = value
        }
        get {
            return self.placeholderLabel.textColor
        }
    }
    
    @IBInspectable var placeholder: String? {
        set (value) {
            self.placeholderLabel.text = value
        }
        get {
            return self.placeholderLabel.text
        }
    }
    
    override var bounds: CGRect {
        didSet {
            self.placeholderLabel.preferredMaxLayoutWidth = self.frame.width
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        self.removeObserver(self, forKeyPath: "text")
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize () {
        self.setupInsets()
        self.setupPlaceholder()
        
        self.addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions.New, context: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewDidBeginEditing:", name: UITextViewTextDidBeginEditingNotification, object: self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewDidChange:", name: UITextViewTextDidChangeNotification, object: self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewDidEndEditing:", name: UITextViewTextDidEndEditingNotification, object: self)
    }
    
    private func setupInsets () {
        self.textContainerInset = UIEdgeInsetsMake(-4,0,0,0)
        self.textContainer.lineFragmentPadding = 0
    }
    
    private func setupPlaceholder () {
        self.placeholderLabel.preferredMaxLayoutWidth = self.frame.width
        self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.placeholderLabel.textColor = RGBA(198, 198, 204, 1)
        self.placeholderLabel.userInteractionEnabled = false
        self.placeholderLabel.numberOfLines = 0
        self.placeholderLabel.font = self.font
        
        self.addSubview(self.placeholderLabel)
        
        let insets = self.textContainerInset
        let views = ["label": self.placeholderLabel]
        let metrics = ["LEFT": insets.left, "TOP": insets.top, "RIGHT": insets.right, "BOTTOM": insets.bottom]
        
        var constraints:[NSLayoutConstraint] = []
        
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-LEFT-[label]-RIGHT-|", options: [], metrics: metrics, views: views) 
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-TOP-[label]-(>=BOTTOM)-|", options: [], metrics: metrics, views: views) 
        for constraint in constraints {
            constraint.priority = 751
        }
        
        self.addConstraints(constraints)
        self.textViewDidChange(nil)
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
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath ==  "text" || object as? NSObject == self {
            self.textViewDidChange(nil)
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    //MARK: - Notifications
    func textViewDidBeginEditing (sender: AnyObject?) {
        
    }
    
    func textViewDidChange (sender: AnyObject?) {
        if self.text.characters.count == 0 {
            self.placeholderLabel.hidden = false
        } else {
            self.placeholderLabel.hidden = true
        }
    }
    
    func textViewDidEndEditing (sender: AnyObject?) {
        
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
