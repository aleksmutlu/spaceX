//
//  GraphQLWorldDataStore.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Apollo
import Domain
import Foundation

public final class GraphQLWorldDataStore: RemoteWorldDataStore {
    
    private let apollo: ApolloClient
    private var countries = [String: Country]()
    
    private var timer: Timer!
    
    public init(apollo: ApolloClient) {
        self.apollo = apollo
        
        
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            if let angola = self?.countries["AO"] {
                angola.temperature.accept(.random(in: (-10...50)))
            }
        })
    }
    
    public func fetchContinents(onCompletion: @escaping (Result<[Continent], Error>) -> Void) {
        apollo.fetch(query: ContinentsQuery(), cachePolicy: .returnCacheDataElseFetch) { result in
            switch result {
            case .success(let queryResult):
                if let continents = queryResult.data?.toDomain() {
                    onCompletion(.success(continents))
                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    public func fetchCountries(
        by continentCode: String,
        onCompletion: @escaping (Result<[Country], Error>) -> Void
    ) {
        apollo.fetch(
            query: CountriesQuery(code: continentCode),
            cachePolicy: .returnCacheDataElseFetch
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let queryResult):
                if let domain = queryResult.data?.toDomain() {
                    self.countries = Dictionary(uniqueKeysWithValues: domain.map { ($0.code, $0) } )
                    onCompletion(.success(domain))
                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    public func fetchCountry(
        by code: String,
        onCompletion: @escaping (Result<CountryDetails, Error>) -> Void
    ) {
        apollo.fetch(
            query: CountryQuery(code: code),
            cachePolicy: .returnCacheDataElseFetch
        ) { result in
            switch result {
            case .success(let queryResult):
                if let domain = queryResult.data?.country?.toDomain() {
                    onCompletion(.success(domain))
                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
