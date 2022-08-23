//
//  LaunchRepository.swift
//  Domain
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Foundation

public protocol LaunchRepository {
    func fetchLaunches()
    func fetchLaunch(by id: String)
}
