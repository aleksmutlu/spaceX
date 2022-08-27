//
//  RemoteLaunchDataStore.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation

public protocol RemoteLaunchDataStore {
    func fetchLaunches(onCompletion: @escaping (Result<[Launch], Error>) -> Void)
}
