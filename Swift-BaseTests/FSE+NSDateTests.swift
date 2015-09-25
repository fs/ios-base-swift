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
    
    let randomInterval = {() -> NSTimeInterval in
        let hours       = NSTimeInterval(arc4random_uniform(23))*60*60
        let minutes     = NSTimeInterval(arc4random_uniform(59))*60
        let seconds     = NSTimeInterval(arc4random_uniform(59))
        let interval = hours + minutes + seconds
        return interval
    }
    
    let timezoneFromInterval = {(interval: NSTimeInterval) -> NSTimeInterval in
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate(timeIntervalSince1970: interval)
        
        let timezoneOffset = NSTimeInterval(calendar.timeZone.secondsFromGMT)
        let daylightOffset = calendar.timeZone.isDaylightSavingTimeForDate(date) ? calendar.timeZone.daylightSavingTimeOffset : 0
        
        return timezoneOffset + daylightOffset
    }
    
    let timezoneFromDate = {(date: NSDate) -> NSTimeInterval in
        let calendar = NSCalendar.currentCalendar()
        
        let timezoneOffset = NSTimeInterval(calendar.timeZone.secondsFromGMT)
        let daylightOffset = calendar.timeZone.isDaylightSavingTimeForDate(date) ? calendar.timeZone.daylightSavingTimeOffset : 0
        
        return timezoneOffset + daylightOffset
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDatePeriodInit () {
        for _ in 0 ..< 5 {
            let timestamp = NSDate().timeIntervalSince1970
            let localTimestamp = timestamp - timestamp%(24*60*60) - self.timezoneFromInterval(timestamp)
            
            let today       = NSDate(timeIntervalSince1970: localTimestamp + self.randomInterval())
            let tomorrow    = NSDate(timeIntervalSince1970: localTimestamp + self.randomInterval() + 24*60*60)
            let farAway     = NSDate(timeIntervalSince1970: localTimestamp + self.randomInterval() + 10*24*60*60)
            
            XCTAssertEqual(DatePeriod(date: today),     DatePeriod.Today, "Must be today")
            XCTAssertEqual(DatePeriod(date: tomorrow),  DatePeriod.Tomorrow, "Must be tomorrow")
            XCTAssertEqual(DatePeriod(date: farAway),   DatePeriod.Unknow, "Must be unknow")
        }
    }
    
    func testMidnightDate () {
        
        for _ in 0 ..< 10 {
            
            let random = NSTimeInterval(arc4random())
            let timestamp = random - random%(24*60*60)
            
            let localMidnightTimestamp = timestamp - self.timezoneFromInterval(timestamp)
            
            let midnightDate = NSDate(timeIntervalSince1970: localMidnightTimestamp)
            
            let first = NSDate(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval())
            let second = NSDate(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval())
            
            let yesterday = NSDate(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval() - 24*60*60)
            let tomorrow = NSDate(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval() + 24*60*60)
            
            XCTAssertEqual(midnightDate, first.midnightDate(),      "Must be equal")
            XCTAssertEqual(midnightDate, second.midnightDate(),     "Must be equal")
            
            XCTAssertNotEqual(midnightDate, yesterday.midnightDate(),   "Must be less")
            XCTAssertNotEqual(midnightDate, tomorrow.midnightDate(),    "Must be grather")
            
        }
    }
    
    func testIsSameWeekAsDate()
    {
        let dayInterval: NSTimeInterval = 24*60*60
        
        for _ in 0 ..< 10 {
            
            let value = NSTimeInterval(arc4random())
            
            //1 january of 1970 is thursday (index is 5) so I calculate correction
            let firstWeekday = NSTimeInterval(NSCalendar.currentCalendar().firstWeekday)
            let correctionDays: NSTimeInterval = 7 - 5 + firstWeekday
            
            let minMidnightInterval = value + (correctionDays*dayInterval) - value%(7*24*60*60)
            let maxMidnightInterval = minMidnightInterval + dayInterval*7 - 1
            
            let minInterval = UInt(minMidnightInterval - self.timezoneFromInterval(minMidnightInterval))
            let maxInterval = UInt(maxMidnightInterval - self.timezoneFromInterval(maxMidnightInterval))
            
            let lessDate        = NSDate(timeIntervalSince1970: NSTimeInterval(minInterval) - 1)
            let greatherDate    = NSDate(timeIntervalSince1970: NSTimeInterval(maxInterval) + 1)
            
            let values: [NSDate] = {
                var values: [NSDate] = []
                for _ in 0 ..< 10 {
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
        for _ in 0 ..< 10 {
            let random = NSTimeInterval(arc4random())
            
            let timestamp               = random - random%(24*60*60)
            let localMidnightTimestamp  = timestamp - self.timezoneFromInterval(timestamp)
            
            let date = NSDate(timeIntervalSince1970: localMidnightTimestamp)
            
            let first   = NSDate(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval())
            let second  = NSDate(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval())
            
            let yesterday   = NSDate(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval() - 24*60*60)
            let tomorrow    = NSDate(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval() + 24*60*60)
            
            XCTAssertTrue(date.isEqualToDateIgnoringTime(first), "Must be equal")
            XCTAssertTrue(date.isEqualToDateIgnoringTime(second), "Must be equal")
            
            XCTAssertFalse(date.isEqualToDateIgnoringTime(yesterday), "Must be less")
            XCTAssertFalse(date.isEqualToDateIgnoringTime(tomorrow), "Must be greather")
        }
        
    }
    
    func testDateByAddingDays () {
        for _ in 0 ..< 10 {
            let date = NSDate(timeIntervalSince1970: NSTimeInterval(arc4random()))
            let value = Int(arc4random_uniform(100))
            
            let timeInterval:NSTimeInterval = date.timeIntervalSinceReferenceDate + 24*60*60 * NSTimeInterval(value)
            
            let etalon = NSDate(timeIntervalSinceReferenceDate: timeInterval)
            let result = date.dateByAddingDays(value)
            
            XCTAssertEqual(etalon, result, "Must be equal")
        }
    }
    
    func testTomorrow () {
        for _ in 0 ..< 10 {
            let timestamp = NSTimeInterval(arc4random())
            
            let date = NSDate(timeIntervalSince1970: timestamp)
            let etalon = NSDate(timeIntervalSince1970: timestamp + 24*60*60)
            let result = date.tomorrow
            
            XCTAssertTrue(etalon == result, "Must be same date")
        }
    }
    
    
    
}
