//
//  LaunchListItemViewModel.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation

public struct LaunchListItemViewModel: Hashable {
    
    public let missionName: String
    public let rocketName: String?
    public let dateString: String?
    public let patchImageURL: URL?
}

extension LaunchListItemViewModel {
    
    init(launch: Launch) {
        missionName = launch.missionName ?? "Aleks" // TODO: Remove
        rocketName = launch.rocketName
        if let date = launch.date {
            dateString = dateFormatter.string(from: date)
        } else {
            dateString = nil
        }
        patchImageURL = launch.patchImageURL
    }
}

// TODO: Move this formatter into a class with other formatters
private var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM\ndd"
    return dateFormatter
}()
