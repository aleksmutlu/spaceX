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
    
    private let fetchLaunchUseCase: FetchCountryUseCase
    private var launch: Country
    
    // MARK: - Life cycle
    
    public init(fetchLaunchUseCase: FetchCountryUseCase, launch: Country) {
        self.fetchLaunchUseCase = fetchLaunchUseCase
        self.launch = launch
    }
}

// MARK: - DetailViewModelInputs

public protocol DetailViewModelInputs {
    func viewDidLoad()
}

extension DefaultDetailViewModel: DetailViewModelInputs {
    
    public func viewDidLoad() {
        fetchLaunchUseCase.execute(countryCode: launch.code) { [weak self] result in
            switch result {
            case .success(let countryDetails):
                var sectionViewModels = [DetailSectionViewModel]()
                if !countryDetails.languages.isEmpty {
                    sectionViewModels.append(
                        DetailSectionViewModel(
                            sectionTitle: "Languages",
                            detail: countryDetails.languages.joined(separator: ", ")
                        )
                    )
                }
                if !countryDetails.states.isEmpty {
                    sectionViewModels.append(
                        DetailSectionViewModel(
                            sectionTitle: "States",
                            detail: countryDetails.states.joined(separator: ", ")
                        )
                    )
                }
                self?.detailSectionInput.onNext(sectionViewModels)
            case .failure(let error):
                self?.detailSectionInput.onNext([])
            }
        }
    }
}

// MARK: - DetailViewModelOutputs

public protocol DetailViewModelOutputs {
    var headerData: CountryListItemViewModel { get }
    var detailSection: Observable<[DetailSectionViewModel]> { get }
}

extension DefaultDetailViewModel: DetailViewModelOutputs {
    
    public var headerData: CountryListItemViewModel {
        CountryListItemViewModel(launch: launch)
    }
    
    public var detailSection: Observable<[DetailSectionViewModel]> {
        detailSectionInput.asObservable()
    }
}
