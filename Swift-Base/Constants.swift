//
//  Constants.swift
//  Swift-Base
//
//  Created by Kruperfone on 02.10.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//

import UIKit

/*----------API keys---------*/
//For API Keys use prefix ABKeyAPI where AB is capital letters of your project name
//For example: 'SBKeyAPIMock' for Swift-Base

/*--------------User Defaults keys-------------*/
let SBKeyUserDefaultsDeviceTokenData    = "kUserDefaultsDeviceTokenData"
let SBKeyUserDefaultsDeviceTokenString  = "kUserDefaultsDeviceTokenString"

/*----------Notifications---------*/
//For Notifications use prefix ABNotif where AB is capital letters of your project name
//For example: 'SBNotifMock' for Swift-Base

/*--------------Fonts-------------*/

//Example of custom font family name
enum AppFont: Int {
    case Regular = 0
    case Bold
    case Italic
    
    static var allValues: [AppFont] {
        var fonts: [AppFont] = []
        var i = 0
        while let font = AppFont(rawValue: i) {
            fonts.append(font)
            i++
        }
        return fonts
    }
    
    static let familyName = "FontFamilyName"
    var familyName: String {return AppFont.familyName}
    
    var description : String {
        switch self {
        case .Regular:  return "FontFamilyName-Regular";
        case .Bold:     return "FontFamilyName-Bold";
        case .Italic:   return "FontFamilyName-Italic";
        }
    }
    
    func font (size:CGFloat) -> UIFont? {
        switch self {
        case .Regular:  return UIFont(name: self.description, size: size)
        case .Bold:     return UIFont(name: self.description, size: size)
        case .Italic:   return UIFont(name: self.description, size: size)
        }
    }
}

/*----------Colors----------*/

//Example of custom color schemes in application
let AppColor              = UIColor.clearColor()
