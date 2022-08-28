//
//  FetchCountryUseCase.swift
//  Domain
//
//  Created by Aleks Mutlu on 27.08.2022.
//

import Foundation

public protocol FetchCountryUseCase {
    func execute(countryCode: String, onCompletion: @escaping (Result<CountryDetails, Error>) -> Void)
}

public final class DefaultFetchCountryUseCase: FetchCountryUseCase {
 
    private let countryRepository: CountryRepository
    
    public init(countryRepository: CountryRepository) {
        self.countryRepository = countryRepository
    }
    
    public func execute(
        countryCode: String,
        onCompletion: @escaping (Result<CountryDetails, Error>) -> Void
    ) {
        countryRepository.fetchCountry(by: countryCode) { result in
            switch result {
            case .success(let launch):
                onCompletion(.success(launch))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
