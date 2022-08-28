//
//  FetchCountriesUseCase.swift
//  Domain
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Foundation

public protocol FetchCountriesUseCase {
    func execute(continentCode: String, onCompletion: @escaping (Result<[Country], Error>) -> Void)
}

public final class DefaultFetchCountriesUseCase: FetchCountriesUseCase {
    
    private let countryRepository: CountryRepository
    
    public init(countryRepository: CountryRepository) {
        self.countryRepository = countryRepository
    }
    
    public func execute(continentCode: String, onCompletion: @escaping (Result<[Country], Error>) -> Void) {
        countryRepository.fetchCountries(by: continentCode) { result in
            switch result {
            case .success(let launches):
                onCompletion(.success(launches))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
