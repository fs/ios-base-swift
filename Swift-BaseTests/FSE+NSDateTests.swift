//
//  FSE+NSDateTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import Swift_Base

class FSE_NSDateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDatePeriodInit () {
        let today = NSDate()
        let tomorrow = NSDate(timeInterval: 24*60*60, sinceDate: today)
        let thisWeek = NSDate(timeInterval: 2*24*60*60, sinceDate: today)
    }
    
    func testIsDateToday () {
//        return NSDate().midnightDate() == self.midnightDate()
    }
    
    func testIsTomorrow () {
//        return self.isEqualToDateIgnoringTime(NSDate.dateTomorrow())
    }
    
    func testIsThisWeek () {
//        return self.isSameWeekAsDate(NSDate())
    }
    
    func testMidnightDate () {
//        let calendar = NSCalendar.currentCalendar()
//        let components = calendar.components( [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: self)
//        return calendar.dateFromComponents(components)!
    }
    
    func testIsSameWeekAsDate()
    {
        let calendar = NSCalendar.currentCalendar()
        let dayInterval: NSTimeInterval = 24*60*60
        let timezone = NSTimeInterval(NSTimeZone.defaultTimeZone().secondsFromGMT)
        let daylight = {(date: NSDate) -> NSTimeInterval in
            return calendar.timeZone.isDaylightSavingTimeForDate(date) ? calendar.timeZone.daylightSavingTimeOffset : 0
        }
        
        for _ in 0 ..< 5 {
            
            let value = NSTimeInterval(arc4random())
            
            //1 january of 1970 is thursday (index is 5) so I calculate correction
            let firstWeekday = NSTimeInterval(NSCalendar.currentCalendar().firstWeekday)
            let correctionDays: NSTimeInterval = 7 - 5 + firstWeekday
            
            let minMidnightInterval = value + (correctionDays*dayInterval) - value%(7*24*60*60)
            let maxMidnightInterval = minMidnightInterval + dayInterval*7 - 1
            
            let minTimezoneOffset: NSTimeInterval = {
                let date = NSDate(timeIntervalSince1970: minMidnightInterval)
                return -(timezone + daylight(date))
            }()
            let maxTimezoneOffset: NSTimeInterval = {
                let date = NSDate(timeIntervalSince1970: maxMidnightInterval)
                return -(timezone + daylight(date))
            }()
            
            let minInterval = UInt(minMidnightInterval + minTimezoneOffset)
            let maxInterval = UInt(maxMidnightInterval + maxTimezoneOffset)
            
            let lessDate = NSDate(timeIntervalSince1970: NSTimeInterval(minInterval) - 1)
            let greatherDate = NSDate(timeIntervalSince1970: NSTimeInterval(maxInterval) + 1)
            
            let values: [NSDate] = {
                var values: [NSDate] = []
                for _ in 0 ..< 100 {
                    let timestamp: NSTimeInterval = NSTimeInterval(UInt32(minInterval) + arc4random_uniform(UInt32(maxInterval - minInterval - 1)))
                    values.append(NSDate(timeIntervalSince1970: timestamp))
                }
                return values
            }()
            
            for first in values {
                for second in values {
                    XCTAssertTrue(first.isSameWeekAsDate(second), "Must be same week")
                }
                XCTAssertFalse(first.isSameWeekAsDate(lessDate), "Must be less")
                XCTAssertFalse(first.isSameWeekAsDate(greatherDate), "Must be greather")
            }
        }
    }
    
    func testIsEqualToDateIgnoringTime () {
        
        let values: [NSTimeInterval] = [NSTimeInterval(arc4random()), NSTimeInterval(arc4random()), NSTimeInterval(arc4random())]
        
        for value in values {
            let interval = value - value%(24*60*60)
            let base = NSDate(timeIntervalSince1970: interval)
            
            let randomInterval = {() -> NSTimeInterval in
                let hours       = NSTimeInterval(arc4random_uniform(23))*60*60
                let minutes     = NSTimeInterval(arc4random_uniform(59))*60
                let seconds     = NSTimeInterval(arc4random_uniform(59))
                let interval = hours + minutes + seconds
                return interval
            }
            
            let first = NSDate(timeInterval: randomInterval(), sinceDate: base)
            let second = NSDate(timeInterval: randomInterval(), sinceDate: base)
            
            let calendar = NSCalendar.currentCalendar()
            let comps: NSCalendarUnit =
            [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Weekday, NSCalendarUnit.WeekdayOrdinal]
            
            
            let components1 = calendar.components(comps, fromDate:first)
            let components2 = calendar.components(comps, fromDate:second)
            
            let isSameDate =  (components1.year == components2.year) &&
                (components1.month == components2.month) &&
                (components1.day == components2.day)
            
            XCTAssertTrue(isSameDate, "Must be same day ignoting time")
        }
        
    }
    
    func testDateByAddingDays () {
        
        let date = NSDate()
        let values: [Int] = [Int(arc4random_uniform(100)), Int(arc4random_uniform(100)), Int(arc4random_uniform(100))]
        
        for value in values {
            let timeInterval:NSTimeInterval = date.timeIntervalSinceReferenceDate + TimePeriod.Day.rawValue * NSTimeInterval(value)
            let etalon = NSDate(timeIntervalSinceReferenceDate: timeInterval)
            
            let result = date.dateByAddingDays(value)
            
            XCTAssertEqual(etalon, result, "Must be equal")
        }
    }
    
    func testTomorrow () {
        let date = NSDate()
        let etalon = date.dateByAddingDays(1)
        let result = NSDate.tomorrow
        
        
        let calendar = NSCalendar.currentCalendar()
        let comps: NSCalendarUnit =
        [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Weekday, NSCalendarUnit.WeekdayOrdinal]
        
        
        let components1 = calendar.components(comps, fromDate:etalon)
        let components2 = calendar.components(comps, fromDate:result)
        let isSameDate =  (components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day)

        XCTAssertTrue(isSameDate, "Must be same date")
    }
    
    
    
}
