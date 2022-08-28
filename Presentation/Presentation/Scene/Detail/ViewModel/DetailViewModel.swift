//
//  DetailViewModel.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation
import RxCocoa
import RxSwift

public protocol DetailViewModel {
    var inputs: DetailViewModelInputs { get }
    var outputs: DetailViewModelOutputs { get }
}

public final class DefaultDetailViewModel: DetailViewModel {
    
    // MARK: - Properties
    
    public var inputs: DetailViewModelInputs { self }
    public var outputs: DetailViewModelOutputs { self }
    
    private let detailSectionInput = PublishSubject<[DetailSectionViewModel]>()
    private let hudActionsInput = PublishSubject<DetailHUDActions>()
    private let headerDataInput = PublishSubject<CountryListItemViewModel>()
    
    private let fetchCountryUseCase: FetchCountryUseCase
    private var country: Country
    
    // MARK: - Life cycle
    
    public init(fetchCountryUseCase: FetchCountryUseCase, country: Country) {
        self.fetchCountryUseCase = fetchCountryUseCase
        self.country = country
    }
    
    // MARK: - Helpers
    
    private func fetchCountryDetail(by countryCode: String) {
        fetchCountryUseCase.execute(countryCode: country.code) { [weak self] result in
            switch result {
            case .success(let countryDetails):
                self?.handleCountyDetails(countryDetails)
            case .failure:
                self?.handleError()
            }
        }
    }
    
    private func handleCountyDetails(_ countryDetails: CountryDetails) {
        let sectionViewModels = generateSecionViewModels(from: countryDetails)
        detailSectionInput.onNext(sectionViewModels)
        updateHUD(.idle)
    }
    
    private func handleError() {
        updateHUD(.showError(title: "Oops! Something went wrong...")) // TODO: Constants?
    }
    
    private func generateSecionViewModels(
        from countryDetails: CountryDetails
    ) -> [DetailSectionViewModel] {
        var sectionViewModels = [DetailSectionViewModel]()
        if !countryDetails.languages.isEmpty {
            sectionViewModels.append(
                DetailSectionViewModel(
                    sectionTitle: "Languages",
                    detailItems: countryDetails.languages
                )
            )
        }
        if !countryDetails.states.isEmpty {
            sectionViewModels.append(
                DetailSectionViewModel(
                    sectionTitle: "States",
                    detailItems: countryDetails.states
                )
            )
        }
        return sectionViewModels
    }
    
    private func updateHUD(_ action: DetailHUDActions) {
        hudActionsInput.onNext(action)
    }
}

// MARK: - DetailViewModelInputs

public protocol DetailViewModelInputs {
    func viewDidLoad()
    func refetchTapped()
}

extension DefaultDetailViewModel: DetailViewModelInputs {
    
    public func viewDidLoad() {
        updateHUD(.showLoading)
        headerDataInput.onNext(CountryListItemViewModel(country: country))
        fetchCountryDetail(by: country.code)
    }
    
    public func refetchTapped() {
        updateHUD(.showLoading)
        fetchCountryDetail(by: country.code)
    }
}

// MARK: - DetailViewModelOutputs

public protocol DetailViewModelOutputs {
    var headerData: Observable<CountryListItemViewModel> { get }
    var detailSection: Observable<[DetailSectionViewModel]> { get }
    var hudActions: Observable<DetailHUDActions> { get }
}

extension DefaultDetailViewModel: DetailViewModelOutputs {
    
    public var headerData: Observable<CountryListItemViewModel> { headerDataInput.asObservable() }
    
    public var detailSection: Observable<[DetailSectionViewModel]> {
        detailSectionInput.asObservable()
    }
    
    public var hudActions: Observable<DetailHUDActions> { hudActionsInput.asObservable() }
}
