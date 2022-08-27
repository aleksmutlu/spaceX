//
//  FetchLaunchUseCase.swift
//  Domain
//
//  Created by Aleks Mutlu on 27.08.2022.
//

import Foundation

public protocol FetchLaunchUseCase {
    func execute(launchID: String, onCompletion: @escaping (Result<Launch, Error>) -> Void)
}

public final class DefaultFetchLaunchUseCase: FetchLaunchUseCase {
 
    private let launchRepository: LaunchRepository
    
    public init(launchRepository: LaunchRepository) {
        self.launchRepository = launchRepository
    }
    
    public func execute(launchID: String, onCompletion: @escaping (Result<Launch, Error>) -> Void) {
        launchRepository.fetchLaunch(by: launchID) { result in
            switch result {
            case .success(let launch):
                onCompletion(.success(launch))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
