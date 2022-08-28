//
//  HomeViewModelTests.swift
//  PresentationTests
//
//  Created by Aleks Mutlu on 28.08.2022.
//

@testable import Domain
@testable import Presentation
import XCTest

class HomeViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    // generateContinentListItemViewModels
    /*
     
     Bu method country verilmediginde sadece continent,
     Ilgili indexe country list verildiginde sadece oraya aktarmali
     
     */
    
    // expandTapped
    /*
     Sectionlar 3 state'e sahip
     open, switch, close
     
     bu statelerde datanin sifirlandigindan emin olmam lazim
     openSectionIndex takip edilmeli
     */
}
