//
//  HomeViewModelTests.swift
//  PresentationTests
//
//  Created by Aleks Mutlu on 28.08.2022.
//

@testable import Domain
@testable import Presentation
import RxSwift
import XCTest

private class ContinentSectionsIndexSpy {
    private(set) var values: [Int?] = []
    private let disposeBag = DisposeBag()
    
    init(_ observable: Observable<DisplayContinentsData>) {
        observable
            .subscribe { [weak self] (_, sectionIndex) in
                self?.values.append(sectionIndex)
            }
            .disposed(by: disposeBag)
    }
}

private class ContinentSectionsDataSpy {
    private(set) var values: [ContinentListItemViewModel] = []
    private let disposeBag = DisposeBag()
    
    init(_ observable: Observable<DisplayContinentsData>) {
        observable
            .subscribe { [weak self] (viewModels, _) in
                self?.values = viewModels
            }
            .disposed(by: disposeBag)
    }
}

final class HomeViewModelTests: XCTestCase {
    
    var mockFetchContinentsUseCase: MockFetchContinentsUseCase!
    var mockFetchCountriesUseCase: MockFetchCountriesUseCase!
    var sut: DefaultHomeViewModel!
    
    func generateContinentsStub(count: Int) -> [Continent] {
        Array(repeating: .stub, count: count)
    }
    
    func generateCountriesStubs(count: Int) -> [Country] {
        Array(repeating: .stub, count: count)
    }
    
    override func setUp() {
        mockFetchContinentsUseCase = MockFetchContinentsUseCase()
        mockFetchCountriesUseCase = MockFetchCountriesUseCase()
        sut = DefaultHomeViewModel(
            fetchContinentsUseCase: mockFetchContinentsUseCase,
            fetchCountriesUseCase: mockFetchCountriesUseCase,
            onCoordinatorActionTrigger: nil
        )
    }
    
    override func tearDown() {
        mockFetchCountriesUseCase = nil
        mockFetchContinentsUseCase = nil
        sut = nil
    }
    
    func testFetchContinentsOnViewDidLoad() {
        // Given
        
        let continentsStub = generateContinentsStub(count: 5)
        mockFetchContinentsUseCase.resultData = continentsStub
        
        let spy = ContinentSectionsDataSpy(sut.outputs.displayContinents)
        
        // When
        
        sut.inputs.viewDidLoad() // Fetch continents
        
        // Then
        
        XCTAssertTrue(spy.values.count == 5, "🚨 Invalid continent count")
    }
    
    func testContinentTap_ExpandCollapse() {
        // Given
        
        let continentsStub = generateContinentsStub(count: 5)
        mockFetchContinentsUseCase.resultData = continentsStub
        let countriesStub = generateCountriesStubs(count: 5)
        mockFetchCountriesUseCase.resultData = countriesStub
        
        let spy = ContinentSectionsIndexSpy(sut.outputs.displayContinents)
        
        // When
        
        sut.inputs.viewDidLoad() // Fetch continents, active section: nil
        
        sut.inputs.continentTapped(at: 1) // Expand, active section: 1
        
        sut.inputs.continentTapped(at: 1) // Collapse, active section: nil
        
        // Then
        
        let result: [Int?] = [nil, 1, nil]
        XCTAssertEqual(spy.values, result, "🚨 Invalid section state")
    }
    
    func testContinentTap_ExpandSwitch() {
        // Given
        
        let continentsStub = generateContinentsStub(count: 5)
        mockFetchContinentsUseCase.resultData = continentsStub
        let countriesStub = generateCountriesStubs(count: 5)
        mockFetchCountriesUseCase.resultData = countriesStub
        
        let spy = ContinentSectionsIndexSpy(sut.outputs.displayContinents)
        
        // When
        
        sut.inputs.viewDidLoad() // Fetch continents, active section: nil
        
        sut.inputs.continentTapped(at: 1) // Expand, active section: 1
        
        sut.inputs.continentTapped(at: 2) // Collapse, active section: 2
        
        // Then
        
        let result: [Int?] = [nil, 1, 2]
        XCTAssertEqual(spy.values, result, "🚨 Invalid section state")
    }
    
    func testContinentTap_FetchCountries() {
        // Given
        
        let continentsStub = generateContinentsStub(count: 3)
        mockFetchContinentsUseCase.resultData = continentsStub
        let countriesStub = generateCountriesStubs(count: 5)
        mockFetchCountriesUseCase.resultData = countriesStub
        
        let spy = ContinentSectionsDataSpy(sut.outputs.displayContinents)
        
        // When
        
        sut.inputs.viewDidLoad() // Fetch continents
        
        sut.inputs.continentTapped(at: 1)
        
        // Then
        
        XCTAssertTrue(spy.values[0].countryListItems.count == 0, "🚨 Invalid section received data")
        XCTAssertTrue(spy.values[1].countryListItems.count == 5, "🚨 Invalid section received data")
        XCTAssertTrue(spy.values[2].countryListItems.count == 0, "🚨 Invalid section received data")
    }
    
    func testCountryTap_TriggerCoordinatorAction() {
        // Given
        
        let continentsStub = generateContinentsStub(count: 3)
        mockFetchContinentsUseCase.resultData = continentsStub
        let countriesStub: [Country] = [
            .stub,
            .stub,
            Country(code: "TESTRandom1234", name: "", capital: "", emoji: "", phone: "")
        ]
        
        mockFetchCountriesUseCase.resultData = countriesStub
        
        let expectation = expectation(description: "🚨 Expected to trigger selection action")
        
        let onCoordinatorActionTrigger: (HomeSceneCoordinatorActions) -> Void = { action in
            switch action {
            case .select(let country):
                XCTAssertEqual(country.code, "TESTRandom1234", "🚨 Unexpected country selected")
                expectation.fulfill()
            }
        }
        sut = DefaultHomeViewModel(
            fetchContinentsUseCase: mockFetchContinentsUseCase,
            fetchCountriesUseCase: mockFetchCountriesUseCase,
            onCoordinatorActionTrigger: onCoordinatorActionTrigger
        )
        
        // When
        
        sut.inputs.viewDidLoad()
        
        sut.inputs.continentTapped(at: 1)
        
        sut.inputs.countryTapped(at: 2)
        
        waitForExpectations(timeout: 1)
    }
    
    func testRefetchContinents() {
        // Given
        
        let continentsStub = generateContinentsStub(count: 5)
        mockFetchContinentsUseCase.resultData = continentsStub
        
        let spy = ContinentSectionsDataSpy(sut.outputs.displayContinents)
        
        // When
        
        sut.inputs.refetchTapped() // Fetch continents
        
        // Then
        
        XCTAssertTrue(spy.values.count == 5, "🚨 Invalid continent count")
    }
}
