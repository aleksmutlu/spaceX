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
    
    private let detailSectionInput = PublishSubject<DetailSectionViewModel?>()
    
    private let fetchLaunchUseCase: FetchLaunchUseCase
    private var launch: Launch
    
    // MARK: - Life cycle
    
    public init(fetchLaunchUseCase: FetchLaunchUseCase, launch: Launch) {
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
        fetchLaunchUseCase.execute(launchID: launch.id!) { [weak self] result in
            switch result {
            case .success(let launch):
                if let detail = launch.detail {
                    self?.launch.detail = launch.detail
                    self?.detailSectionInput.onNext(
                        DetailSectionViewModel(
                            sectionTitle: "Details",
                            detail: detail
                        )
                    )
                } else {
                    self?.detailSectionInput.onNext(nil)
                }
                
            case .failure(let error):
                self?.detailSectionInput.onNext(nil)
            }
        }
        
    }
}

// MARK: - DetailViewModelOutputs

public protocol DetailViewModelOutputs {
    var headerData: LaunchListItemViewModel { get }
    var detailSection: Observable<DetailSectionViewModel?> { get }
}

extension DefaultDetailViewModel: DetailViewModelOutputs {
    
    public var headerData: LaunchListItemViewModel {
        LaunchListItemViewModel(launch: launch)
    }
    
    public var detailSection: Observable<DetailSectionViewModel?> {
        detailSectionInput.asObservable()
    }
}
