//
//  ColorTests.swift
//  UseCaseTests
//
//  Created by Rodrigo Souza on 04/10/22.
//

import XCTest

final class ColorTests: XCTestCase {

    func testColorsExistInAssetCatalog() {
        for color in Color.allCases {
            let uiColor = UIColor(named: color.rawValue)
            XCTAssertNotNil(uiColor, "Asset catalog is missing an entry for \(color.rawValue)")
        }
    }

}
