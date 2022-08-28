//
//  FetchContinentsUseCase.swift
//  Domain
//
//  Created by Aleks Mutlu on 27.08.2022.
//

import Foundation

public protocol FetchContinentsUseCase {
    func execute(onCompletion: @escaping (Result<[Continent], Error>) -> Void)
}

public final class DefaultFetchContinentsUseCase: FetchContinentsUseCase {
 
    private let worldRepository: WorldRepository
    
    public init(worldRepository: WorldRepository) {
        self.worldRepository = worldRepository
    }
    
    public func execute(onCompletion: @escaping (Result<[Continent], Error>) -> Void) {
        worldRepository.fetchContinents() { result in
            switch result {
            case .success(let continents):
                onCompletion(.success(continents))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}

