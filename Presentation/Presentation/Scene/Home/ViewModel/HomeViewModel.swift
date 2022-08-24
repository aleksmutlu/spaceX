//
//  HomeViewModel.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation
import RxCocoa
import RxSwift

public protocol HomeViewModel: AnyObject {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

public final class DefaultHomeViewModel: HomeViewModel {
    
    // MARK: - Properties
    
    public var inputs: HomeViewModelInputs { self }
    public var outputs: HomeViewModelOutputs { self }
    
    private let launchItemsInput: BehaviorRelay<[LaunchListItemViewModel]> = .init(value: [])
    private let fetchLaunchesUseCase: FetchLaunchesUseCase
    
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
    func didSelectItem(at index: Int)
}

extension DefaultHomeViewModel: HomeViewModelInputs {
    
    public func viewDidLoad() {
        fetchLaunchesUseCase.execute { [weak self] result in
            switch result {
            case .success(let launches):
                let l = self!.generateLaunchListItemViewModels(from: launches)
                self?.launchItemsInput.accept(l)
            case .failure(let error):
            // TODO: Handle error
                break
            }
        }
    }
    
    public func didSelectItem(at index: Int) {
        print("Navigate to launch: \(launchItemsInput.value[index].missionName)")
    }
}

// MARK: - HomeViewModelOutputs

public protocol HomeViewModelOutputs {
    var launchItems: Observable<[LaunchListItemViewModel]> { get }
}

extension DefaultHomeViewModel: HomeViewModelOutputs {
    public var launchItems: Observable<[LaunchListItemViewModel]> {
        launchItemsInput.asObservable()
    }
}
