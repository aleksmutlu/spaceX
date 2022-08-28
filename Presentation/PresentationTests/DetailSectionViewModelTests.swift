//
//  DetailSectionViewModelTests.swift
//  PresentationTests
//
//  Created by Aleks Mutlu on 28.08.2022.
//

@testable import Presentation
import XCTest

final class DetailSectionViewModelTests: XCTestCase {

    func testDetailSectionFormat() {
        // Given
        
        let title = "States"
        let states = ["Istanbul", "Ankara"]
        
        // When
        
        let sut = DetailSectionViewModel(sectionTitle: title, detailItems: states)
        
        // Then
        
        XCTAssertTrue(sut.sectionTitle == title, "🚨 Formatting Title failed")
        XCTAssertTrue(sut.detail == "Istanbul, Ankara", "🚨 Formatting Detail failed")
    }
}
