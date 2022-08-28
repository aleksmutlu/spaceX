//
//  MockFetchCountriesUseCase.swift
//  PresentationTests
//
//  Created by Aleks Mutlu on 28.08.2022.
//

import Domain
import Foundation

final class MockFetchCountriesUseCase: FetchCountriesUseCase {
    
    var resultData: [Country] = []
    
    func execute(continentCode: String, onCompletion: @escaping (Result<[Country], Error>) -> Void) {
        onCompletion(.success(resultData))
    }
}
