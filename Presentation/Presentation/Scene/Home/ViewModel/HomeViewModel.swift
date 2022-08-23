//
//  HomeViewModel.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation

public protocol HomeViewModel: AnyObject {
    
}

public final class DefaultHomeViewModel: HomeViewModel {
    
    private let fetchLaunchesUseCase: FetchLaunchesUseCase
    
    public init(fetchLaunchesUseCase: FetchLaunchesUseCase) {
        self.fetchLaunchesUseCase = fetchLaunchesUseCase
        
        fetchLaunchesUseCase.execute { result in
            switch result {
            case .success(let launches):
                print(launches)
                break
            case .failure(let error):
            // TODO: Handle error
                break
            }
        }
    }
    
}
