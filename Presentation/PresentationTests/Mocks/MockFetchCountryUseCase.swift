//
//  MockFetchCountryUseCase.swift
//  PresentationTests
//
//  Created by Aleks Mutlu on 28.08.2022.
//

import Domain
import Foundation

final class MockFetchCountryUseCase: FetchCountryUseCase {
    
    var isExecutionComplete = false
    var countryDetailResponse: CountryDetails!
    
    func execute(
        countryCode: String,
        onCompletion: @escaping (Result<CountryDetails, Error>) -> Void
    ) {
        isExecutionComplete = true
        onCompletion(.success(countryDetailResponse))
    }
}
