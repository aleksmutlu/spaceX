//
//  API+Extensions.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation

extension LaunchesQuery.Data {
    
    func toDomain() -> [Launch] {
        let launches = launchesPast?.compactMap { $0?.toDomain() } ?? []
        return launches
    }
}

extension LaunchesQuery.Data.LaunchesPast {
    
    func toDomain() -> Launch {
        Launch(
            id: id,
            missionName: missionName,
            dateString: launchDateUtc,
            rocketName: rocket?.rocketName,
            patchImageURLString: links?.missionPatchSmall,
            detail: nil
        )
    }
}
