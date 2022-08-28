//
//  CountryListItemViewModelTests.swift
//  PresentationTests
//
//  Created by Aleks Mutlu on 28.08.2022.
//

@testable import Domain
@testable import Presentation
import XCTest

final class CountryListItemViewModelTests: XCTestCase {
    
    func testCountryListItemViewModel_FormatsCountry_Successfully() {
        // Given
        
        let country = Country.stub
        
        // When
        
        let sut = CountryListItemViewModel(launch: country)
        
        // Then

        XCTAssert(sut.name == country.name, "🚨 Failed to format Country Name")
        XCTAssert(sut.capital == country.capital, "🚨 Failed to format Capital")
        XCTAssert(sut.flag == country.emoji, "🚨 Failed to format Flag")
        XCTAssertNotNil(country.phone, "🚨 Failed to unwrap Phone Code")
        XCTAssert(sut.phone == "+\(country.phone!)", "🚨 Failed to format Phone Code")
    }
}
