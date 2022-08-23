//
//  FetchLaunchesUseCase.swift
//  Domain
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Foundation

public protocol FetchLaunchesUseCase {
    func execute(onCompletion: @escaping (Result<[Launch], Error>) -> Void)
}

public final class DefaultFetchLaunchesUseCase: FetchLaunchesUseCase {
    
    private let launchRepository: LaunchRepository
    
    public init(launchRepository: LaunchRepository) {
        self.launchRepository = launchRepository
    }
    
    public func execute(onCompletion: @escaping (Result<[Launch], Error>) -> Void) {
        launchRepository.fetchLaunches { result in
            switch result {
            case .success(let launches):
                onCompletion(.success(launches))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
