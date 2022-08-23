//
//  LaunchRepository.swift
//  Domain
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Foundation

public protocol LaunchRepository {
    func fetchLaunches(onCompletion: @escaping (Result<[Launch], Error>) -> Void)
    func fetchLaunch(by id: String)
}
