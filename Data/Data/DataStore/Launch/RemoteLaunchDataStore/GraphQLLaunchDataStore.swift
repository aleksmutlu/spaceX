//
//  GraphQLLaunchDataStore.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Apollo
import Domain
import Foundation

public final class GraphQLLaunchDataStore: RemoteLaunchDataStore {
    
    // TODO: inject
    let cl = ApolloClient(url: URL(string: "https://api.spacex.land/graphql/")!)
    
    public init() {
        
    }
    
    public func fetchLaunches(
        onCompletion: @escaping (Result<[Launch], Error>) -> Void
    ) {
        cl.fetch(query: LaunchesQuery()) { result in
            switch result {
            case .success(let queryResult):
                
                // TODO: Error Handling?
                if let domain = queryResult.data?.toDomain() {
                    onCompletion(.success(domain))
                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
