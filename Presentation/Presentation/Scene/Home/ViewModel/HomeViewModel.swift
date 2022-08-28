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
    case select(country: Country)
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
    private let fetchCountriesUseCase: FetchCountriesUseCase
    
    private var continents: [Continent] = []
    private var countries: [Country] = []
    private let onCoordinatorActionTrigger: (HomeViewCoordinatorActions) -> Void
    
    private var openSectionIndex: Int? = nil
    
    public init(
        fetchContinentsUseCase: FetchContinentsUseCase,
        fetchCountriesUseCase: FetchCountriesUseCase,
        onCoordinatorActionTrigger: @escaping (HomeViewCoordinatorActions) -> Void
    ) {
        self.fetchContinentsUseCase = fetchContinentsUseCase
        self.fetchCountriesUseCase = fetchCountriesUseCase
        self.onCoordinatorActionTrigger = onCoordinatorActionTrigger
    }
    
    // MARK: - Helpers
    
    private func generateContinentListItemViewModels(
        from continents: [Continent],
        countries: [Country] = [],
        continentIndex: Int? = nil
    ) -> [ContinentListItemViewModel] {
        var continentItems: [ContinentListItemViewModel] = continents.enumerated().map {
            let state: ContinentHeaderViewState
            if let openSectionIndex = openSectionIndex {
                state = openSectionIndex == $0.offset ? .expanded : .collapsed
            } else {
                state = .collapsed
            }
            return ContinentListItemViewModel(continent: $0.element, state: state)
        }
        if let continentIndex = continentIndex {
            continentItems[continentIndex].countryListItems = countries.map(
                CountryListItemViewModel.init
            )
        }
        return continentItems
    }
    
    private func fetchCountries(of continentCode: String, index: Int) {
        fetchCountriesUseCase.execute(continentCode: continentCode) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let countries):
                let continentItems = self.generateContinentListItemViewModels(
                    from: self.continents,
                    countries: countries,
                    continentIndex: index
                )
                
                self.countries = countries
                let action: HomeState.DisplayAction
                action = self.openSectionIndex == nil ? .collapse : .expand(index: self.openSectionIndex!)
                self.stateInput.onNext(
                    .display(
                        continents: continentItems, action: action
                    )
                )
            case.failure(let error):
                // TODO:
                break
            }
        }
    }
}

// MARK: - HomeViewModelInputs

public protocol HomeViewModelInputs {
    func viewDidLoad()
    func didSelectItem(at index: Int)
    func expandTapped(at index: Int)
    func refetchTapped()
}

extension DefaultHomeViewModel: HomeViewModelInputs {
    
    public func viewDidLoad() {
        fetchContinentsUseCase.execute { [weak self] result in
            switch result {
            case .success(let continents):
                self?.continents = continents
                let viewModels = self?.generateContinentListItemViewModels(from: continents) ?? []
                self?.stateInput.onNext(.display(continents: viewModels, action: .collapse))
            case .failure(let error):
                self?.stateInput.onNext(.error(title: "Oops! Something went wrong..."))
            }
        }
        
        // TODO: Unnecessary Reactivity
        navigationBarTitleInput.onNext("World")

        stateInput.onNext(.idle)
    }
    
    public func didSelectItem(at index: Int) { // TODO: Rename this
        let country = countries[index]
        onCoordinatorActionTrigger(.select(country: country))
    }
    
    public func expandTapped(at index: Int) {
        if let openSectionIndex = openSectionIndex {
        // TODO: Duplicate
            if openSectionIndex == index { // Close
                self.openSectionIndex = nil
                let viewModels = generateContinentListItemViewModels(from: continents, continentIndex: index)
                countries = []
                stateInput.onNext(.display(continents: viewModels, action: .collapse))
            } else { // Switch to another
                self.openSectionIndex = index
                let continent = continents[index]
                fetchCountries(of: continent.code, index: index)
            }
        } else { // Open
            openSectionIndex = index
            let continent = continents[index]
            fetchCountries(of: continent.code, index: index)
        }
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
