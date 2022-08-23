//
//  API+Extensions.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Foundation

extension LaunchesQuery.Data {
    
    func toDTO() -> FetchLaunchesResponse {
        let dtoLaunches = launches?.compactMap { $0?.toDTO() } ?? []
        return FetchLaunchesResponse(launches: dtoLaunches)
    }
}

extension LaunchesQuery.Data.Launch {
    
    func toDTO() -> FetchLaunchesResponse.Launch {
        FetchLaunchesResponse.Launch(missionName: missionName)
    }
}
