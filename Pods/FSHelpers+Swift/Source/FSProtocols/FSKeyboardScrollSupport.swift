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
    
    func fs_keyboardScrollSupportKeyboardWillShow (_ notif: Notification)
    func fs_keyboardScrollSupportKeyboardWillHide (_ notif: Notification)
}

public extension FSKeyboardScrollSupport {
    var fs_keyboardScrollSupportActiveField  : UIView? {
        return nil
    }
}

public extension FSKeyboardScrollSupport where Self: AnyObject {
    
    func fs_keyboardScrollSupportRemoveNotifications () {
        
        let center = NotificationCenter.default
        
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}

public extension FSKeyboardScrollSupport where Self: UIViewController {
    
    func fs_keyboardScrollSupportKeyboardWillShow (_ notif: Notification) {
        
        guard let scrollView = self.fs_keyboardScrollSupportScrollView else {return}
        
        guard let info = (notif as NSNotification).userInfo else {return}
        guard let value = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardFrame = value.cgRectValue
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
        
        let convertedRect = superview.convert(activeField.frame, to: self.view)
        
        if !viewRect.contains(convertedRect.origin)  {
            scrollView.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
    
    func fs_keyboardScrollSupportKeyboardWillHide (_ notif: Notification) {
        
        guard let scrollView = self.fs_keyboardScrollSupportScrollView else {return}
        
        let contentInsets = UIEdgeInsets.zero
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
