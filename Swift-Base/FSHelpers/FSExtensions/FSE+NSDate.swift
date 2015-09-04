//
//  FSE+NSDate.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import Foundation

enum TimePeriod:NSTimeInterval {
    case Second = 1
    case Minute = 60
    case Hour = 3600
    case Day = 86400
    case Week = 604800
}

enum DatePeriod:Int {
    case Unknow = -1
    case Today = 0
    case Tomorrow = 1
    case ThisWeek = 2
    
    init (date:NSDate) {
        
        if date.isDateToday() {
            self = .Today
            return
        }
        
        if date.isTomorrow() {
            self = .Tomorrow
            return
        }
        
        if date.isThisWeek() {
            self = .ThisWeek
            return
        }
        
        self = .Unknow
    }
}

extension NSDate {
    
    func isDateToday () -> Bool {
        return NSDate().midnightDate() == self.midnightDate()
    }
    
    func isTomorrow () -> Bool {
        return self.isEqualToDateIgnoringTime(NSDate.dateTomorrow())
    }
    
    func isThisWeek () -> Bool {
        return self.isSameWeekAsDate(NSDate())
    }
    
    func midnightDate () -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components( NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay, fromDate: self)
        return calendar.dateFromComponents(components)!
    }
    
    func isSameWeekAsDate(date:NSDate) -> Bool
    {
        let calendar = NSCalendar.currentCalendar()
        let comps =
        NSCalendarUnit.CalendarUnitYear |
            NSCalendarUnit.CalendarUnitMonth |
            NSCalendarUnit.CalendarUnitDay |
            NSCalendarUnit.CalendarUnitWeekOfYear |
            NSCalendarUnit.CalendarUnitHour |
            NSCalendarUnit.CalendarUnitMinute |
            NSCalendarUnit.CalendarUnitSecond |
            NSCalendarUnit.CalendarUnitWeekday |
            NSCalendarUnit.CalendarUnitWeekdayOrdinal
        
        let components1 = calendar.components(comps, fromDate:self)
        let components2 = calendar.components(comps, fromDate:date)
        
        // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
        if components1.weekOfYear != components2.weekOfYear {
            return false
        }
        
        // Must have a time interval under 1 week. Thanks @aclark
        return (abs(self.timeIntervalSinceDate(date)) < TimePeriod.Week.rawValue)
    }
    
    func isEqualToDateIgnoringTime (date:NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        let comps =
        NSCalendarUnit.CalendarUnitYear |
            NSCalendarUnit.CalendarUnitMonth |
            NSCalendarUnit.CalendarUnitDay |
            NSCalendarUnit.CalendarUnitWeekOfYear |
            NSCalendarUnit.CalendarUnitHour |
            NSCalendarUnit.CalendarUnitMinute |
            NSCalendarUnit.CalendarUnitSecond |
            NSCalendarUnit.CalendarUnitWeekday |
            NSCalendarUnit.CalendarUnitWeekdayOrdinal
        
        
        let components1 = calendar.components(comps, fromDate:self)
        let components2 = calendar.components(comps, fromDate:date)
        return  (components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day)
    }
    
    class func dateTomorrow () -> NSDate
    {
        return NSDate.dateWithDaysFromNow(1)
    }
    
    class func dateWithDaysFromNow(days:Int) -> NSDate
    {
        let timeInterval:NSTimeInterval = NSDate().timeIntervalSinceReferenceDate + TimePeriod.Day.rawValue * NSTimeInterval(days)
        let newDate = NSDate(timeIntervalSinceReferenceDate: timeInterval)
        return newDate
    }
}
