//
//  DefaultLaunchRepository.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain

public final class DefaultLaunchRepository: WorldRepository {
    
    private let remoteLaunchDataStore: RemoteCountryDataStore
    
    public init(remoteLaunchDataStore: RemoteCountryDataStore) {
        self.remoteLaunchDataStore = remoteLaunchDataStore
    }
    
    public func fetchContinents(onCompletion: @escaping (Result<[Continent], Error>) -> Void)  {
        remoteLaunchDataStore.fetchContinents { result in
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
        remoteLaunchDataStore.fetchCountries(by: continentCode) { result in
            switch result {
            case .success(let launches):
                onCompletion(.success(launches))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    public func fetchCountry(
        by code: String,
        onCompletion: @escaping (Result<CountryDetails, Error>) -> Void
    ) {
        remoteLaunchDataStore.fetchCountry(by: code) { result in
            switch result {
            case .success(let launch):
                onCompletion(.success(launch))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
