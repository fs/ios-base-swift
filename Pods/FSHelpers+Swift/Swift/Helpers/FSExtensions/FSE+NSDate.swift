//
//  FSE+NSDate.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import Foundation

public enum FSTimePeriod:NSTimeInterval {
    case Second     = 1
    case Minute     = 60
    case Hour       = 3600
    case Day        = 86400
    case Week       = 604800
}

// MARK: Time Period
private func FS_ConvertToInterval (value: Any, period: FSTimePeriod) -> NSTimeInterval {
    guard let number = value as? NSNumber else {return 0}
    let interval = NSTimeInterval(number.doubleValue)
    return interval * period.rawValue
}

public extension IntegerType {
    public var fs_seconds  : NSTimeInterval {return FS_ConvertToInterval(self, period: .Second)}
    public var fs_minutes  : NSTimeInterval {return FS_ConvertToInterval(self, period: .Minute)}
    public var fs_hours    : NSTimeInterval {return FS_ConvertToInterval(self, period: .Hour)}
    public var fs_days     : NSTimeInterval {return FS_ConvertToInterval(self, period: .Day)}
    public var fs_weeks    : NSTimeInterval {return FS_ConvertToInterval(self, period: .Week)}
}

public extension FloatingPointType {
    public var fs_seconds  : NSTimeInterval {return FS_ConvertToInterval(self, period: .Second)}
    public var fs_minutes  : NSTimeInterval {return FS_ConvertToInterval(self, period: .Minute)}
    public var fs_hours    : NSTimeInterval {return FS_ConvertToInterval(self, period: .Hour)}
    public var fs_days     : NSTimeInterval {return FS_ConvertToInterval(self, period: .Day)}
    public var fs_weeks    : NSTimeInterval {return FS_ConvertToInterval(self, period: .Week)}
}

public enum FSDatePeriod:Int {
    case Unknow     = -1
    case Today      = 0
    case Tomorrow   = 1
    case ThisWeek   = 2
    
    public init (date:NSDate) {
        
        if date.fs_isDateToday() {
            self = .Today
            return
        }
        
        if date.fs_isTomorrow() {
            self = .Tomorrow
            return
        }
        
        if date.fs_isThisWeek() {
            self = .ThisWeek
            return
        }
        
        self = .Unknow
    }
}

public extension NSTimeInterval {
    public var fs_timezone: NSTimeInterval {
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate(timeIntervalSince1970: self)
        
        let timezoneOffset = NSTimeInterval(calendar.timeZone.secondsFromGMT)
        let daylightOffset = calendar.timeZone.isDaylightSavingTimeForDate(date) ? calendar.timeZone.daylightSavingTimeOffset : 0
        
        return timezoneOffset + daylightOffset
    }
}

public extension NSDate {
    
    public var fs_timezone: NSTimeInterval {
        return self.timeIntervalSince1970.fs_timezone
    }
    
    public func fs_isDateToday () -> Bool {
        return NSDate().fs_midnightDate() == self.fs_midnightDate()
    }
    
    public func fs_isTomorrow () -> Bool {
        return self.fs_isEqualToDateIgnoringTime(NSDate().fs_tomorrow)
    }
    
    public func fs_isThisWeek () -> Bool {
        return self.fs_isSameWeekAsDate(NSDate())
    }
    
    public func fs_midnightDate () -> NSDate {
        
        let timestamp = self.timeIntervalSince1970 + self.fs_timezone
        let midnightTimestamp = timestamp - timestamp%(FSTimePeriod.Day.rawValue)
        
        let result = NSDate(timeIntervalSince1970: midnightTimestamp - midnightTimestamp.fs_timezone)
        return result
    }
    
    public func fs_isSameWeekAsDate(date:NSDate) -> Bool
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
            
            let wholeWeeks = Int(interval/FSTimePeriod.Week.rawValue)
            
            //Getting previous thursday interval
            let thursday = NSTimeInterval(wholeWeeks)*FSTimePeriod.Week.rawValue
            
            //Calculate difference (in days) between current time and previous Thursday
            let differenseDays = Int((interval - thursday)/FSTimePeriod.Day.rawValue)
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
        let weekInterval = NSTimeInterval(numberOfWeeks) * FSTimePeriod.Week.rawValue
        //Calculate days which we must deduct to get first weekday
        let correctionDays: NSTimeInterval = 5 - NSTimeInterval(calendar.firstWeekday)
        //Convert correction days to time interval in seconds
        let correctionInterval = correctionDays*FSTimePeriod.Day.rawValue
        //Get first weekday timestamp (Sunday for USA and Monday for Russia for example)
        let firstWeekday = weekInterval - correctionInterval
        
        //Get timestamp of the first weekday and last weekday
        let minMidnightInterval = firstWeekday
        let maxMidnightInterval = minMidnightInterval + FSTimePeriod.Week.rawValue - 1
        
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
    
    public func fs_isEqualToDateIgnoringTime (date:NSDate) -> Bool {
        return self.fs_midnightDate() == date.fs_midnightDate()
    }
    
    public func fs_dateByAddingDays (days: Int) -> NSDate {
        let timeInterval:NSTimeInterval = self.timeIntervalSinceReferenceDate + FSTimePeriod.Day.rawValue * NSTimeInterval(days)
        let newDate = NSDate(timeIntervalSinceReferenceDate: timeInterval)
        return newDate
    }
    
    public var fs_tomorrow: NSDate {
        return self.fs_dateByAddingDays(1)
    }
}
