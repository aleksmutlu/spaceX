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

public enum HomeSceneCoordinatorActions {
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
    
    private let displayContinentsInput = PublishSubject<DisplayContinentsData>()
    private let hudActionInput = BehaviorSubject<HomeHUDAction>(value: .idle)
    
    private let fetchContinentsUseCase: FetchContinentsUseCase
    private let fetchCountriesUseCase: FetchCountriesUseCase
    
    private var continents: [Continent] = []
    private var countries: [Country] = []
    private let onCoordinatorActionTrigger: ((HomeSceneCoordinatorActions) -> Void)?
    
    private var activeSectionIndex: Int? = nil
    
    public init(
        fetchContinentsUseCase: FetchContinentsUseCase,
        fetchCountriesUseCase: FetchCountriesUseCase,
        onCoordinatorActionTrigger: ((HomeSceneCoordinatorActions) -> Void)?
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
            if let openSectionIndex = activeSectionIndex {
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
    
    private func fetchContinents() {
        fetchContinentsUseCase.execute { [weak self] result in
            switch result {
            case .success(let continents):
                self?.handleContinents(continents)
            case .failure:
                self?.handleError()
            }
        }
    }
    
    private func handleContinents(_ continents: [Continent]) {
        self.continents = continents
        let viewModels = generateContinentListItemViewModels(from: continents)
        hudActionInput.onNext(.idle)
        displayContinentsInput.onNext((viewModels, nil))
    }
    
    private func fetchCountries(of continentCode: String, index: Int) {
        fetchCountriesUseCase.execute(continentCode: continentCode) { [weak self] result in
            switch result {
            case .success(let countries):
                self?.handleCountries(countries, index: index)
            case.failure:
                self?.handleError()
            }
        }
    }
    
    private func handleCountries(_ countries: [Country], index: Int) {
        self.countries = countries
        hudActionInput.onNext(.idle)
        
        let viewModels = generateContinentListItemViewModels(
            from: continents,
            countries: countries,
            continentIndex: index
        )
        displayContinentsInput.onNext((viewModels, activeSectionIndex))
    }
    
    private func handleError() {
        activeSectionIndex = nil
        hudActionInput.onNext(.showError(title: "Oops! Something went wrong..."))
    }
    
    private func expandSection(at index: Int) {
        activeSectionIndex = index
        let continent = continents[index]
        fetchCountries(of: continent.code, index: index)
    }
    
    private func collapseSection(at index: Int) {
        activeSectionIndex = nil
        let viewModels = generateContinentListItemViewModels(from: continents, continentIndex: index)
        countries = []
        displayContinentsInput.onNext((viewModels, nil))
    }
}

// MARK: - HomeViewModelInputs

public protocol HomeViewModelInputs {
    func viewDidLoad()
    func countryTapped(at index: Int)
    func continentTapped(at index: Int)
    func refetchTapped()
}

extension DefaultHomeViewModel: HomeViewModelInputs {
    
    public func viewDidLoad() {
        hudActionInput.onNext(.showLoading)
        fetchContinents()
    }
    
    public func countryTapped(at index: Int) {
        let country = countries[index]
        onCoordinatorActionTrigger?(.select(country: country))
    }
    
    public func continentTapped(at index: Int) {
        print(index)
        if let openSectionIndex = activeSectionIndex {
            if openSectionIndex == index { // Close
                collapseSection(at: index)
            } else { // Switch to another
                expandSection(at: index)
            }
        } else { // Open
            expandSection(at: index)
        }
    }
    
    public func refetchTapped() {
        hudActionInput.onNext(.showLoading)
        fetchContinents()
    }
}

// MARK: - HomeViewModelOutputs

public protocol HomeViewModelOutputs {
    var navigationBarTitle: String { get }
    var displayContinents: Observable<DisplayContinentsData> { get }
    var hudAction: Observable<HomeHUDAction> { get }
}

extension DefaultHomeViewModel: HomeViewModelOutputs {
    public var navigationBarTitle: String { "World 🌏" }
    public var displayContinents: Observable<DisplayContinentsData> {
        displayContinentsInput.asObservable()
    }
    public var hudAction: Observable<HomeHUDAction> { hudActionInput.asObservable() }
}


