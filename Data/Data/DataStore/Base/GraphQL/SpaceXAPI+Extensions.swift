//
//  API+Extensions.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Foundation

extension LaunchesQuery.Data {
    
    func toDTO() -> FetchLaunchesResponseDTO {
        let dtoLaunches = launchesPast?.compactMap { $0?.toDTO() } ?? []
        return FetchLaunchesResponseDTO(launches: dtoLaunches)
    }
}

extension LaunchesQuery.Data.LaunchesPast {
    
    func toDTO() -> FetchLaunchesResponseDTO.Launch {
        FetchLaunchesResponseDTO.Launch(
            id: id,
            missionName: missionName,
            dateString: launchDateUtc,
            rocketName: rocket?.rocketName,
            patchImageURLString: links?.missionPatchSmall
        )
    }
}
