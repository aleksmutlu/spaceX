//
//  HomeViewModel.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation

public protocol HomeViewModel: AnyObject {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

public final class DefaultHomeViewModel: HomeViewModel {
    
    // MARK: - Properties
    
    public var inputs: HomeViewModelInputs { self }
    public var outputs: HomeViewModelOutputs { self }
    
    private let fetchLaunchesUseCase: FetchLaunchesUseCase
    public var onLaunchListRetreived: (([LaunchListItemViewModel]) -> Void)?
    
    public init(fetchLaunchesUseCase: FetchLaunchesUseCase) {
        self.fetchLaunchesUseCase = fetchLaunchesUseCase
    }
    
    // MARK: - Helpers
    
    private func generateLaunchListItemViewModels(
        from launches: [Launch]
    ) -> [LaunchListItemViewModel] {
        launches.map(LaunchListItemViewModel.init)
    }
}

// MARK: - HomeViewModelInputs

public protocol HomeViewModelInputs {
    func viewDidLoad()
}

extension DefaultHomeViewModel: HomeViewModelInputs {
    
    public func viewDidLoad() {
        fetchLaunchesUseCase.execute { [weak self] result in
            switch result {
            case .success(let launches):
                self?.onLaunchListRetreived?(self!.generateLaunchListItemViewModels(from: launches))
            case .failure(let error):
            // TODO: Handle error
                break
            }
        }
    }
}

// MARK: - HomeViewModelOutputs

public protocol HomeViewModelOutputs {
    var onLaunchListRetreived: (([LaunchListItemViewModel]) -> Void)? { get set }
}

extension DefaultHomeViewModel: HomeViewModelOutputs {
    
}
