//
//  MockFetchContinentsUseCase.swift
//  PresentationTests
//
//  Created by Aleks Mutlu on 28.08.2022.
//

import Domain
import Foundation

final class MockFetchContinentsUseCase: FetchContinentsUseCase {
    
    var resultData: [Continent] = []
    
    func execute(onCompletion: @escaping (Result<[Continent], Error>) -> Void) {
        onCompletion(.success(resultData))
    }
}
