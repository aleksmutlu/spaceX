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
    
    private let navigationBarTitleInput: PublishSubject<String?> = .init()
    private let stateInput: BehaviorSubject<HomeState> = .init(value: .idle)
    
    private let fetchLaunchesUseCase: FetchLaunchesUseCase
    
    private var launches: [Launch] = []
    
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
    func refetchTapped()
}

extension DefaultHomeViewModel: HomeViewModelInputs {
    
    public func viewDidLoad() {
        fetchLaunchesUseCase.execute { [weak self] result in
            switch result {
            case .success(let launches):
                self?.launches = launches
                let l = self?.generateLaunchListItemViewModels(from: launches) ?? []
                self?.stateInput.onNext(.display(launches: l, animated: true, shouldResetOld: false))
            case .failure(let error):
                self?.stateInput.onNext(.error(title: "Oops! Something went wrong..."))
            }
        }
        
        // TODO: Unnecessary Reactivity
        navigationBarTitleInput.onNext("SpaceX Launches")

        stateInput.onNext(.idle)
    }
    
    public func didSelectItem(at index: Int) {
        print("Navigate to launch: \(launches[index].missionName)")
    }
    
    public func refetchTapped() {
        print("Refetch")
    }
}

// MARK: - HomeViewModelOutputs

public protocol HomeViewModelOutputs {
    var navigationBarTitle: Observable<String?>? { get }
    var state: Observable<HomeState> { get }
}

extension DefaultHomeViewModel: HomeViewModelOutputs {
    public var navigationBarTitle: Observable<String?>? { navigationBarTitleInput.asObservable() }
    public var state: Observable<HomeState> { stateInput.asObservable() }
}
