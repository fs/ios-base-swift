//
//  FSKeyboardScrollSupport.swift
//  FSHelpers
//
//  Created by Kruperfone on 09.11.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

/*
    You must did not forget to call KeyboardScrollSupportKeyboardWillHide: method in your `deinit`
*/

public protocol FSKeyboardScrollSupport {
    /// Scroll view with content that can be under keyboard
    var fs_keyboardScrollSupportScrollView   : UIScrollView?   {get}
    /// Active editable view on the ScrollView
    var fs_keyboardScrollSupportActiveField  : UIView?         {get}
    
    func fs_keyboardScrollSupportRegisterForNotifications  ()
    func fs_keyboardScrollSupportRemoveNotifications       ()
    
    func fs_keyboardScrollSupportKeyboardWillShow (notif: NSNotification)
    func fs_keyboardScrollSupportKeyboardWillHide (notif: NSNotification)
}

public extension FSKeyboardScrollSupport {
    var fs_keyboardScrollSupportActiveField  : UIView? {
        return nil
    }
}

public extension FSKeyboardScrollSupport where Self: AnyObject {
    
    func fs_keyboardScrollSupportRegisterForNotifications () {
        
        let center = NSNotificationCenter.defaultCenter()
        
        center.addObserver(self, selector: "fs_keyboardScrollSupportKeyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: "fs_keyboardScrollSupportKeyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func fs_keyboardScrollSupportRemoveNotifications () {
        
        let center = NSNotificationCenter.defaultCenter()
        
        center.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        center.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
}

public extension FSKeyboardScrollSupport where Self: UIViewController {
    
    func fs_keyboardScrollSupportKeyboardWillShow (notif: NSNotification) {
        
        guard let scrollView = self.fs_keyboardScrollSupportScrollView else {return}
        
        guard let info = notif.userInfo else {return}
        guard let value = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardFrame = value.CGRectValue()
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.height, 0.0)
        
        scrollView.contentInset             = contentInsets
        scrollView.scrollIndicatorInsets    = contentInsets
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        guard let activeField = self.fs_keyboardScrollSupportActiveField else {return}
        
        // By default activeField must be subview of the scrollView
        guard let superview = activeField.superview else {return}
        guard superview == scrollView else {return}
        
        var viewRect = self.view.frame
        viewRect.size.height -= keyboardFrame.height
        
        let convertedRect = superview.convertRect(activeField.frame, toView: self.view)
        
        if !CGRectContainsPoint(viewRect, convertedRect.origin)  {
            scrollView.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
    
    func fs_keyboardScrollSupportKeyboardWillHide (notif: NSNotification) {
        
        guard let scrollView = self.fs_keyboardScrollSupportScrollView else {return}
        
        let contentInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

public extension FSKeyboardScrollSupport where Self: UITableViewController {
    var fs_keyboardScrollSupportScrollView: UIScrollView? {
        return self.tableView
    }
}

public extension FSKeyboardScrollSupport where Self: UICollectionViewController {
    var fs_keyboardScrollSupportScrollView: UIScrollView? {
        return self.collectionView
    }
}
