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
    
    private let worldRepository: WorldRepository
    
    public init(worldRepository: WorldRepository) {
        self.worldRepository = worldRepository
    }
    
    public func execute(continentCode: String, onCompletion: @escaping (Result<[Country], Error>) -> Void) {
        worldRepository.fetchCountries(by: continentCode) { result in
            switch result {
            case .success(let countries):
                onCompletion(.success(countries))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
