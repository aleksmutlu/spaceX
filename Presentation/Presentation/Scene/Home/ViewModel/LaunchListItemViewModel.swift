//
//  LaunchListItemViewModel.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation

public struct LaunchListItemViewModel {
    
    public let missionName: String
}

extension LaunchListItemViewModel {
    
    init(launch: Launch) {
        self.missionName = launch.missionName ?? "Aleks" // TODO: Remove
    }
}
