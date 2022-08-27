//
//  RESTLaunchDataStore.swift
//  Data
//
//  Created by Aleks Mutlu on 27.08.2022.
//

import Domain
import Foundation

public final class RESTLaunchDataStore: RemoteLaunchDataStore {
    
    private let restAPI = RESTAPI()
    
    public init() {
        
    }
    
    public func fetchLaunches(onCompletion: @escaping (Result<[Launch], Error>) -> Void) {
        restAPI.makeRequest { result in
            switch result {
            case .success(let launchesResponse):
                let launches = launchesResponse.map { $0.toDomain() }
                onCompletion(.success(launches))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
