//
//  DetailViewModelTests.swift
//  PresentationTests
//
//  Created by Aleks Mutlu on 28.08.2022.
//

@testable import Domain
@testable import Presentation
import RxSwift
import XCTest

private class SectionViewModelSpy {
    private(set) var values: [DetailSectionViewModel] = []
    private let disposeBag = DisposeBag()
    
    init(_ observable: Observable<[DetailSectionViewModel]>) {
        observable
            .subscribe { [weak self] viewModels in
                self?.values = viewModels
            }
            .disposed(by: disposeBag)
    }
}

final class DetailViewModelTests: XCTestCase {
    var fetchLaunchUseCase: MockFetchCountryUseCase!
    var country: Country!
    var sut: DefaultDetailViewModel!
    
    override func setUp() {
        fetchLaunchUseCase = MockFetchCountryUseCase()
        country = Country.stub
        sut = DefaultDetailViewModel(
            fetchCountryUseCase: fetchLaunchUseCase,
            country: country
        )
    }
    
    override func tearDown() {
        fetchLaunchUseCase = nil
        country = nil
        sut = nil
    }
    
    // TODO: Test state changes including loading
    
    func testFetchCountryDetailsOnViewDidLoad_TwoSectionResult() {
        // Given
        
        let states = ["Istanbul"]
        let languages = ["Turkish"]
        let countryDetail = CountryDetails(states: states, languages: languages)
        fetchLaunchUseCase.countryDetailResponse = countryDetail
        let spy = SectionViewModelSpy(sut.outputs.detailSection)
        
        // When
        
        sut.viewDidLoad()
        
        // Then
        
        XCTAssertTrue(
            fetchLaunchUseCase.isExecutionComplete,
            "🚨 fetchLaunchUseCase case is not executed"
        )
        
        XCTAssertTrue(spy.values.count == 2, "🚨 Expected 2 sections as an output")
    }
    
    
    func testFetchCountryDetailsOnViewDidLoad_ZeroSectionResult() {
        // Given
        
        let countryDetail = CountryDetails(states: [], languages: [])
        fetchLaunchUseCase.countryDetailResponse = countryDetail
        let spy = SectionViewModelSpy(sut.outputs.detailSection)
        
        // When
        
        sut.viewDidLoad()
        
        // Then
        
        XCTAssertTrue(
            fetchLaunchUseCase.isExecutionComplete,
            "🚨 fetchLaunchUseCase case is not executed"
        )
        
        XCTAssertTrue(spy.values.isEmpty, "🚨 Expected 0 section as an output")
    }
    
    func testRefetchCountryDetailsOnViewDidLoad_ZeroSectionResult() {
        // Given
        
        let states = ["Istanbul"]
        let languages = ["Turkish"]
        let countryDetail = CountryDetails(states: states, languages: languages)
        fetchLaunchUseCase.countryDetailResponse = countryDetail
        let spy = SectionViewModelSpy(sut.outputs.detailSection)
        
        // When
        
        sut.refetchTapped()
        
        // Then
        
        XCTAssertTrue(
            fetchLaunchUseCase.isExecutionComplete,
            "🚨 fetchLaunchUseCase case is not executed"
        )
        
        XCTAssertTrue(spy.values.count == 2, "🚨 Expected 2 sections as an output")
    }
}
