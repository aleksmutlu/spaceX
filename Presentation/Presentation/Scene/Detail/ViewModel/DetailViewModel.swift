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
            guard let self = self else { return }
            
            switch result {
            case .success(let countryDetails):
                let sectionViewModels = self.generateSecionViewModels(from: countryDetails)
                self.detailSectionInput.onNext(sectionViewModels)
            case .failure(let error):
                self.detailSectionInput.onNext([])
            }
        }
    }
    
    private func generateSecionViewModels(
        from countryDetails: CountryDetails
    ) -> [DetailSectionViewModel] {
        var sectionViewModels = [DetailSectionViewModel]()
        if !countryDetails.languages.isEmpty {
            sectionViewModels.append(
                DetailSectionViewModel( // TODO: Test
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
}

// MARK: - DetailViewModelInputs

public protocol DetailViewModelInputs {
    func viewDidLoad()
}

extension DefaultDetailViewModel: DetailViewModelInputs {
    
    public func viewDidLoad() {
        fetchCountryDetail(by: country.code)
    }
}

// MARK: - DetailViewModelOutputs

public protocol DetailViewModelOutputs {
    var headerData: CountryListItemViewModel { get }
    var detailSection: Observable<[DetailSectionViewModel]> { get }
}

extension DefaultDetailViewModel: DetailViewModelOutputs {
    
    public var headerData: CountryListItemViewModel {
        CountryListItemViewModel(launch: country)
    }
    
    public var detailSection: Observable<[DetailSectionViewModel]> {
        detailSectionInput.asObservable()
    }
}
