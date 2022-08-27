//
//  DummyLaunchDataStore.swift
//  Data
//
//  Created by Aleks Mutlu on 26.08.2022.
//

import Domain
import Foundation

public final class DummyLaunchDataStore: RemoteLaunchDataStore {
    
    public init() {
        
    }
    
    public func fetchLaunches(onCompletion: @escaping (Result<[Launch], Error>) -> Void) {
        let launches = (0..<10).enumerated().map {
            Launch(
                id: UUID().uuidString,
                missionName: "Dummy Mission \($0.offset + 1)",
                dateString: "2020-05-22T17:39:00.000Z",
                rocketName: "Rocket " + UUID().uuidString,
                patchImageURLString: "https://images2.imgbox.com/eb/0f/Vev7xkUX_o.png",
                detail: nil
            )
        }
        
        onCompletion(.success(launches))
    }
    
    public func fetchLaunch(
        by id: String,
        onCompletion: @escaping (Result<Launch, Error>) -> Void
    ) {
        let launch = Launch(
            id: UUID().uuidString,
            missionName: "Dummy Mission",
            dateString: "2020-05-22T17:39:00.000Z",
            rocketName: "Rocket " + UUID().uuidString,
            patchImageURLString: "https://images2.imgbox.com/eb/0f/Vev7xkUX_o.png",
            detail: "Details"
        )
        onCompletion(.success(launch))
    }
}
