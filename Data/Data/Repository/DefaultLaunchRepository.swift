//
//  DefaultLaunchRepository.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain

public final class DefaultLaunchRepository: LaunchRepository {
    
    private let remoteLaunchDataStore: LaunchDataStore
    
    public init(remoteLaunchDataStore: LaunchDataStore) {
        self.remoteLaunchDataStore = remoteLaunchDataStore
    }
    
    public func fetchLaunch(by id: String) {
        
    }
    
    public func fetchLaunches() {
        
    }
}

