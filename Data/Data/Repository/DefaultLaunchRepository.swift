//
//  DefaultLaunchRepository.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain

public final class DefaultLaunchRepository: LaunchRepository {
    
    private let remoteLaunchDataStore: RemoteLaunchDataStore
    
    public init(remoteLaunchDataStore: RemoteLaunchDataStore) {
        self.remoteLaunchDataStore = remoteLaunchDataStore
    }
    
    public func fetchLaunches(onCompletion: @escaping (Result<[Launch], Error>) -> Void) {
        remoteLaunchDataStore.fetchLaunches { result in
            switch result {
            case .success(let launches):
                onCompletion(.success(launches))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    public func fetchLaunch(by id: String, onCompletion: @escaping (Result<Launch, Error>) -> Void) {
        remoteLaunchDataStore.fetchLaunch(by: id) { result in
            switch result {
            case .success(let launch):
                onCompletion(.success(launch))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
