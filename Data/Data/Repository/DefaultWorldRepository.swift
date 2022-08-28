//
//  DefaultWorldRepository.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain

public final class DefaultWorldRepository: WorldRepository {
    
    private let remoteWorldDataStore: RemoteWorldDataStore
    
    public init(remoteWorldDataStore: RemoteWorldDataStore) {
        self.remoteWorldDataStore = remoteWorldDataStore
    }
    
    public func fetchContinents(onCompletion: @escaping (Result<[Continent], Error>) -> Void)  {
        remoteWorldDataStore.fetchContinents { result in
            switch result {
            case .success(let continents):
                onCompletion(.success(continents))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    public func fetchCountries(
        by continentCode: String,
        onCompletion: @escaping (Result<[Country], Error>) -> Void
    ) {
        remoteWorldDataStore.fetchCountries(by: continentCode) { result in
            switch result {
            case .success(let countries):
                onCompletion(.success(countries))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    public func fetchCountry(
        by code: String,
        onCompletion: @escaping (Result<CountryDetails, Error>) -> Void
    ) {
        remoteWorldDataStore.fetchCountry(by: code) { result in
            switch result {
            case .success(let country):
                onCompletion(.success(country))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
