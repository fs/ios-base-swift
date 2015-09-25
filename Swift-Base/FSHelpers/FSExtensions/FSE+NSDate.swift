//
//  FSE+NSDate.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import Foundation

enum TimePeriod:NSTimeInterval {
    case Second     = 1
    case Minute     = 60
    case Hour       = 3600
    case Day        = 86400
    case Week       = 604800
}

enum DatePeriod:Int {
    case Unknow     = -1
    case Today      = 0
    case Tomorrow   = 1
    case ThisWeek   = 2
    
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

extension NSTimeInterval {
    var timezone: NSTimeInterval {
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate(timeIntervalSince1970: self)
        
        let timezoneOffset = NSTimeInterval(calendar.timeZone.secondsFromGMT)
        let daylightOffset = calendar.timeZone.isDaylightSavingTimeForDate(date) ? calendar.timeZone.daylightSavingTimeOffset : 0
        
        return timezoneOffset + daylightOffset
    }
}

extension NSDate {
    
    var timezone: NSTimeInterval {
        return self.timeIntervalSince1970.timezone
    }
    
    func isDateToday () -> Bool {
        return NSDate().midnightDate() == self.midnightDate()
    }
    
    func isTomorrow () -> Bool {
        return self.isEqualToDateIgnoringTime(NSDate().tomorrow)
    }
    
    func isThisWeek () -> Bool {
        return self.isSameWeekAsDate(NSDate())
    }
    
    func midnightDate () -> NSDate {
        
        let timestamp = self.timeIntervalSince1970 + self.timezone
        let midnightTimestamp = timestamp - timestamp%(TimePeriod.Day.rawValue)
        
        let result = NSDate(timeIntervalSince1970: midnightTimestamp - midnightTimestamp.timezone)
        return result
    }
    
    func isSameWeekAsDate(date:NSDate) -> Bool
    {
        //Compare by date components is not working becouse it's start week from monday
        
        let calendar = NSCalendar.currentCalendar()
        let timezone = NSTimeInterval(calendar.timeZone.secondsFromGMT)
        let daylight = {(date: NSDate) -> NSTimeInterval in
            return calendar.timeZone.isDaylightSavingTimeForDate(date) ? calendar.timeZone.daylightSavingTimeOffset : 0
        }
        
        //Getting interval without timezones
        let greenwichInterval = self.timeIntervalSince1970 + timezone + daylight(self)
        //Getting midnight +0 interval
        let interval = greenwichInterval - greenwichInterval%(24*60*60)
        
        //Calculate number of week (since 1 January 1970 (Thursday))
        let numberOfWeeks: Int = {
            
            let wholeWeeks = Int(interval/TimePeriod.Week.rawValue)
            
            //Getting previous thursday interval
            let thursday = NSTimeInterval(wholeWeeks)*TimePeriod.Week.rawValue
            
            //Calculate difference (in days) between current time and previous Thursday
            let differenseDays = Int((interval - thursday)/TimePeriod.Day.rawValue)
            //Calculate max difference in days. Based on calendar firstday index (1-7 where 1 is Sunday). Thursday index is 4.
            let maxDifference = 1 + calendar.firstWeekday
            
            if differenseDays <= maxDifference {
                //If differenct less or equal to max difference, than previous Thursday and current date is same week
                return wholeWeeks
            } else {
                //If difference greather than max difference - interval in the next week
                return wholeWeeks + 1
            }
        }()
        
        //Get timestamp of current week Thursday
        let weekInterval = NSTimeInterval(numberOfWeeks) * TimePeriod.Week.rawValue
        //Calculate days which we must deduct to get first weekday
        let correctionDays: NSTimeInterval = 5 - NSTimeInterval(calendar.firstWeekday)
        //Convert correction days to time interval in seconds
        let correctionInterval = correctionDays*TimePeriod.Day.rawValue
        //Get first weekday timestamp (Sunday for USA and Monday for Russia for example)
        let firstWeekday = weekInterval - correctionInterval
        
        //Get timestamp of the first weekday and last weekday
        let minMidnightInterval = firstWeekday
        let maxMidnightInterval = minMidnightInterval + TimePeriod.Week.rawValue - 1
        
        //Calculate timezone modifiers
        let minTimezoneOffset: NSTimeInterval = {
            let date = NSDate(timeIntervalSince1970: minMidnightInterval)
            return -(timezone + daylight(date))
        }()
        let maxTimezoneOffset: NSTimeInterval = {
            let date = NSDate(timeIntervalSince1970: maxMidnightInterval)
            return -(timezone + daylight(date))
        }()
        
        //Add timezone to midnight intervals
        let minInterval = UInt(minMidnightInterval + minTimezoneOffset)
        let maxInterval = UInt(maxMidnightInterval + maxTimezoneOffset)
        
        //Get timestamp of comperation date
        let dateInterval = UInt(date.timeIntervalSince1970)
        
        //Check if date is in week interval
        return dateInterval >= minInterval && dateInterval <= maxInterval
    }
    
    func isEqualToDateIgnoringTime (date:NSDate) -> Bool {
        return self.midnightDate() == date.midnightDate()
    }
    
    func dateByAddingDays (days: Int) -> NSDate {
        let timeInterval:NSTimeInterval = self.timeIntervalSinceReferenceDate + TimePeriod.Day.rawValue * NSTimeInterval(days)
        let newDate = NSDate(timeIntervalSinceReferenceDate: timeInterval)
        return newDate
    }
    
    var tomorrow: NSDate {
        return self.dateByAddingDays(1)
    }
}
