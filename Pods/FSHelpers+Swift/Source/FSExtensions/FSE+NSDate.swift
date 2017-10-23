//
//  FSE+NSDate.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import Foundation

public enum FSTimePeriod:TimeInterval {
    case second     = 1
    case minute     = 60
    case hour       = 3600
    case day        = 86400
    case week       = 604800
}

// MARK: Time Period
private func FS_ConvertToInterval (_ value: Any, period: FSTimePeriod) -> TimeInterval {
    guard let number = value as? NSNumber else {return 0}
    let interval = TimeInterval(number.doubleValue)
    return interval * period.rawValue
}

public extension BinaryInteger {
    public var fs_seconds  : TimeInterval {return FS_ConvertToInterval(self, period: .second)}
    public var fs_minutes  : TimeInterval {return FS_ConvertToInterval(self, period: .minute)}
    public var fs_hours    : TimeInterval {return FS_ConvertToInterval(self, period: .hour)}
    public var fs_days     : TimeInterval {return FS_ConvertToInterval(self, period: .day)}
    public var fs_weeks    : TimeInterval {return FS_ConvertToInterval(self, period: .week)}
}

public extension FloatingPoint {
    public var fs_seconds  : TimeInterval {return FS_ConvertToInterval(self, period: .second)}
    public var fs_minutes  : TimeInterval {return FS_ConvertToInterval(self, period: .minute)}
    public var fs_hours    : TimeInterval {return FS_ConvertToInterval(self, period: .hour)}
    public var fs_days     : TimeInterval {return FS_ConvertToInterval(self, period: .day)}
    public var fs_weeks    : TimeInterval {return FS_ConvertToInterval(self, period: .week)}
}

public enum FSDatePeriod:Int {
    case unknow     = -1
    case today      = 0
    case tomorrow   = 1
    case thisWeek   = 2
    
    public init (date:Date) {
        
        if date.fs_isDateToday() {
            self = .today
            return
        }
        
        if date.fs_isTomorrow() {
            self = .tomorrow
            return
        }
        
        if date.fs_isThisWeek() {
            self = .thisWeek
            return
        }
        
        self = .unknow
    }
}

public extension TimeInterval {
    public var fs_timezone: TimeInterval {
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: self)
        
        let timezoneOffset = TimeInterval(calendar.timeZone.secondsFromGMT())
        let daylightOffset = calendar.timeZone.isDaylightSavingTime(for: date) ? calendar.timeZone.daylightSavingTimeOffset() : 0
        
        return timezoneOffset + daylightOffset
    }
}

public extension Date {
    
    public var fs_timezone: TimeInterval {
        return self.timeIntervalSince1970.fs_timezone
    }
    
    public func fs_isDateToday () -> Bool {
        return Date().fs_midnightDate() == self.fs_midnightDate()
    }
    
    public func fs_isTomorrow () -> Bool {
        return self.fs_isEqualToDateIgnoringTime(Date().fs_tomorrow)
    }
    
    public func fs_isThisWeek () -> Bool {
        return self.fs_isSameWeekAsDate(Date())
    }
    
    public func fs_midnightDate () -> Date {
        
        let timestamp = self.timeIntervalSince1970 + self.fs_timezone
        let midnightTimestamp = timestamp - timestamp.truncatingRemainder(dividingBy: (FSTimePeriod.day.rawValue))
        
        let result = Date(timeIntervalSince1970: midnightTimestamp - midnightTimestamp.fs_timezone)
        return result
    }
    
    public func fs_isSameWeekAsDate(_ date:Date) -> Bool
    {
        //Compare by date components is not working becouse it's start week from monday
        
        let calendar = Calendar.current
        let timezone = TimeInterval(calendar.timeZone.secondsFromGMT())
        let daylight = {(date: Date) -> TimeInterval in
            return calendar.timeZone.isDaylightSavingTime(for: date) ? calendar.timeZone.daylightSavingTimeOffset() : 0
        }
        
        //Getting interval without timezones
        let greenwichInterval = self.timeIntervalSince1970 + timezone + daylight(self)
        //Getting midnight +0 interval
        let interval = greenwichInterval - greenwichInterval.truncatingRemainder(dividingBy: (24*60*60))
        
        //Calculate number of week (since 1 January 1970 (Thursday))
        let numberOfWeeks: Int = {
            
            let wholeWeeks = Int(interval/FSTimePeriod.week.rawValue)
            
            //Getting previous thursday interval
            let thursday = TimeInterval(wholeWeeks)*FSTimePeriod.week.rawValue
            
            //Calculate difference (in days) between current time and previous Thursday
            let differenseDays = Int((interval - thursday)/FSTimePeriod.day.rawValue)
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
        let weekInterval = TimeInterval(numberOfWeeks) * FSTimePeriod.week.rawValue
        //Calculate days which we must deduct to get first weekday
        let correctionDays: TimeInterval = 5 - TimeInterval(calendar.firstWeekday)
        //Convert correction days to time interval in seconds
        let correctionInterval = correctionDays*FSTimePeriod.day.rawValue
        //Get first weekday timestamp (Sunday for USA and Monday for Russia for example)
        let firstWeekday = weekInterval - correctionInterval
        
        //Get timestamp of the first weekday and last weekday
        let minMidnightInterval = firstWeekday
        let maxMidnightInterval = minMidnightInterval + FSTimePeriod.week.rawValue - 1
        
        //Calculate timezone modifiers
        let minTimezoneOffset: TimeInterval = {
            let date = Date(timeIntervalSince1970: minMidnightInterval)
            return -(timezone + daylight(date))
        }()
        let maxTimezoneOffset: TimeInterval = {
            let date = Date(timeIntervalSince1970: maxMidnightInterval)
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
    
    public func fs_isEqualToDateIgnoringTime (_ date:Date) -> Bool {
        return self.fs_midnightDate() == date.fs_midnightDate()
    }
    
    public func fs_dateByAddingDays (_ days: Int) -> Date {
        let timeInterval:TimeInterval = self.timeIntervalSinceReferenceDate + FSTimePeriod.day.rawValue * TimeInterval(days)
        let newDate = Date(timeIntervalSinceReferenceDate: timeInterval)
        return newDate
    }
    
    public var fs_tomorrow: Date {
        return self.fs_dateByAddingDays(1)
    }
}
