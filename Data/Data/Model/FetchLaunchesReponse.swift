//
//  FetchLaunchesReponse.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Foundation
import Domain

public struct FetchLaunchesResponse {
    
    public var launches: [Launch]

    func toDomain() -> [Domain.Launch] {
        launches.map { $0.toDomain() }
    }
}

extension FetchLaunchesResponse {
    
    public struct Launch {
        public let missionName: String?
        
        public func toDomain() -> Domain.Launch {
            Domain.Launch(missionName: missionName)
        }
    }
}
