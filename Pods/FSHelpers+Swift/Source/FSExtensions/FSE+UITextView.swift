//
//  FSE+UITextField.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

open class FSTextView :UITextView {
    
    fileprivate(set) var placeholderLabel:UILabel = UILabel()
    
    @IBInspectable open  var placeholderColor:UIColor {
        set (value) {
            self.placeholderLabel.textColor = value
        }
        get {
            return self.placeholderLabel.textColor
        }
    }
    
    @IBInspectable open  var placeholder: String? {
        set (value) {
            self.placeholderLabel.text = value
            self.placeholderLabel.fs_size = self.placeholderLabel.sizeThatFits(CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        }
        get {
            return self.placeholderLabel.text
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            self.placeholderLabel.preferredMaxLayoutWidth = self.frame.width
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.removeObserver(self, forKeyPath: "text")
        self.removeObserver(self, forKeyPath: "bounds")
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    fileprivate func initialize () {
        self.setupInsets()
        self.setupPlaceholder()
        
        self.addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions.new, context: nil)
        self.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidBeginEditing(_:)), name: NSNotification.Name.UITextViewTextDidBeginEditing, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidEndEditing(_:)), name: NSNotification.Name.UITextViewTextDidEndEditing, object: self)
    }
    
    fileprivate func setupInsets () {
        self.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.textContainer.lineFragmentPadding = 0
    }
    
    fileprivate func setupPlaceholder () {
        self.placeholderLabel.preferredMaxLayoutWidth = self.frame.width
        self.placeholderLabel.textColor = FSRGBA(198, 198, 204, 1)
        self.placeholderLabel.isUserInteractionEnabled = false
        self.placeholderLabel.numberOfLines = 0
        self.placeholderLabel.font = self.font
        self.addSubview(self.placeholderLabel)
        self.textViewDidChange(nil)
    }
    
    override class open func fs_getTextHeight (forText text:String, width:CGFloat, font:UIFont) -> CGFloat {
        let textView = FSTextView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        textView.font = font
        textView.text = text
        return textView.fs_textHeight
    }
    
    override open var fs_textHeight:CGFloat {
        return super.fs_textHeight
    }
    
    
    
    private func updatePlaceholderTextPosition () {
        let insets = self.textContainerInset
        self.placeholderLabel.frame = CGRect(x: insets.left, y: insets.right, width: self.bounds.width - (insets.left + insets.right), height: self.font?.lineHeight ?? 0)
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let key = keyPath, object as? NSObject == self else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        switch key {
        case "text":
            self.textViewDidChange(nil)
            
        case "bounds":
            self.updatePlaceholderTextPosition()
            
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    //MARK: - Notifications
    func textViewDidBeginEditing (_ sender: AnyObject?) {
        
    }
    
    func textViewDidChange (_ sender: AnyObject?) {
        if self.text.characters.count == 0 {
            self.placeholderLabel.isHidden = false
        } else {
            self.placeholderLabel.isHidden = true
        }
    }
    
    func textViewDidEndEditing (_ sender: AnyObject?) {
        
    }
    
}

extension UITextView {
    
    class public func fs_getTextHeight (forText text:String, width:CGFloat, font:UIFont) -> CGFloat {
        
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        textView.font = font
        textView.text = text
        return textView.fs_textHeight
    }
    
    public var fs_textHeight:CGFloat {
        let size = self.sizeThatFits(CGSize(width: self.fs_width, height: CGFloat.greatestFiniteMagnitude))
        return size.height + 1
    }
}
