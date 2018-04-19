//
//  FSUITestHelpers.swift
//  TwiageHospital
//
//  Created by Vladimir Goncharov on 25/10/2016.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import XCTest

@available(iOS 9, *)
extension XCUIApplication {
    
    func launchWithTestEnvironment(settings: [ApplicationLaunchSettings]) {
        self.launchEnvironment = ProcessInfo.processInfo.environment
        self.launchEnvironment[TestKeys.testing] = TestingMode.UI.rawValue
        settings.forEach { (currentSetting) in
            self.launchEnvironment[currentSetting.key] = currentSetting.value
        }
        self.launch()
    }
}

extension XCUIElement {
    
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        
        let deleteString = stringValue.characters.map { _ in XCUIKeyboardKeyDelete }.joined(separator: "")
        
        self.typeText(deleteString)
        self.typeText(text)
    }
    
    @discardableResult
    func advanceWheel(up: Bool) -> XCUIElement {
        let startCoord = self.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let endCoord = startCoord.withOffset(CGVector(dx: 0.0, dy: up ? -30.0 : 30.0))
        endCoord.tap()
        return self
    }
}
