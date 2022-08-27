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

public enum HomeViewCoordinatorActions {
    case select(launch: Country)
}

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
    
    private let fetchContinentsUseCase: FetchContinentsUseCase
    
    private var continents: [Continent] = []
    private let onCoordinatorActionTrigger: (HomeViewCoordinatorActions) -> Void
    
    public init(
        fetchContinentsUseCase: FetchContinentsUseCase,
        onCoordinatorActionTrigger: @escaping (HomeViewCoordinatorActions) -> Void
    ) {
        self.fetchContinentsUseCase = fetchContinentsUseCase
        self.onCoordinatorActionTrigger = onCoordinatorActionTrigger
    }
    
    // MARK: - Helpers
    
    private func generateLaunchListItemViewModels(
        from continents: [Continent]
    ) -> [ContinentListItemViewModel] {
        continents.map(ContinentListItemViewModel.init)
    }
}

// MARK: - HomeViewModelInputs

public protocol HomeViewModelInputs {
    func viewDidLoad()
    func didSelectItem(at index: Int, in section: Int)
    func refetchTapped()
}

extension DefaultHomeViewModel: HomeViewModelInputs {
    
    public func viewDidLoad() {
        fetchContinentsUseCase.execute { [weak self] result in
            switch result {
            case .success(let continents):
                self?.continents = continents
                let viewModels = self?.generateLaunchListItemViewModels(from: continents) ?? []
                self?.stateInput.onNext(.display(continents: viewModels, animated: false, shouldResetOld: false))
            case .failure(let error):
                self?.stateInput.onNext(.error(title: "Oops! Something went wrong..."))
            }
        }
        
        // TODO: Unnecessary Reactivity
        navigationBarTitleInput.onNext("SpaceX Launches")

        stateInput.onNext(.idle)
    }
    
    public func didSelectItem(at index: Int, in section: Int) {
        let continent = continents[section]
        let country = continent.countries[index]
        onCoordinatorActionTrigger(.select(launch: country))
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
