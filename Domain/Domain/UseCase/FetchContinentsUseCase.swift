//
//  FetchContinentsUseCase.swift
//  Domain
//
//  Created by Aleks Mutlu on 27.08.2022.
//

import Foundation

public protocol FetchContinentsUseCase {
    func execute(onCompletion: @escaping (Result<[Continent], Error>) -> Void)
}

public final class DefaultFetchContinentsUseCase: FetchContinentsUseCase {
 
    private let countryRepository: CountryRepository
    
    public init(countryRepository: CountryRepository) {
        self.countryRepository = countryRepository
    }
    
    public func execute(onCompletion: @escaping (Result<[Continent], Error>) -> Void) {
        countryRepository.fetchContinents() { result in
            switch result {
            case .success(let continents):
                onCompletion(.success(continents))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}

