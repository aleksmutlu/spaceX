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
    
    // TODO: inject
    let cl = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
    
    public init() {
        
    }
    
    public func fetchContinents(onCompletion: @escaping (Result<[Continent], Error>) -> Void) {
        cl.fetch(query: ContinentsQuery(), cachePolicy: .returnCacheDataElseFetch) { result in
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
        cl.fetch(
            query: CountriesQuery(code: continentCode),
            cachePolicy: .returnCacheDataElseFetch
        ) { result in
            switch result {
            case .success(let queryResult):
//                // TODO: Error Handling?
                if let domain = queryResult.data?.toDomain() {
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
        cl.fetch(
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
