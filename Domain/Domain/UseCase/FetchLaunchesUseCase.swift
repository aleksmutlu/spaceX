//
//  FetchLaunchesUseCase.swift
//  Domain
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Foundation

public protocol FetchLaunchesUseCase {
    func execute()
}

public final class DefaultFetchLaunchesUseCase: FetchLaunchesUseCase {
    
    private let launchRepository: LaunchRepository
    
    public init(launchRepository: LaunchRepository) {
        self.launchRepository = launchRepository
    }
    
    public func execute() {
        
    }
}
