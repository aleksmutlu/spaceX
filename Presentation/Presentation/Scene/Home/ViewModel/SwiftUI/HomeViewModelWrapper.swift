//
//  HomeViewModelWrapper.swift
//  Presentation
//
//  Created by Aleks Mutlu on 1.09.2022.
//

import Foundation
import RxSwift

public final class HomeViewModelWrapper: ObservableObject {
    
    private let viewModel: HomeViewModel?
    private let disposeBag = DisposeBag()
    
    @Published var continents = [ContinentListItemViewModel]()
    
    public init(viewModel: HomeViewModel?) {
        self.viewModel = viewModel
        
        viewModel?.outputs.displayContinents
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] viewModels, _ in
                self?.continents = viewModels
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - HomeViewModelInputs

extension HomeViewModelWrapper: HomeViewModelInputs {
    
    public func viewDidLoad() {
        viewModel?.inputs.viewDidLoad()
    }
    
    public func continentTapped(at index: Int) {
        viewModel?.inputs.continentTapped(at: index)
    }
    
    public func countryTapped(at index: Int) {
        viewModel?.inputs.countryTapped(at: index)
    }
    
    public func refetchTapped() {
        viewModel?.inputs.refetchTapped()
    }
    
    public func search(currencyCode: String?) {
        
    }

    public func willEndSearch() {
        
    }
    
    public func willBeginSearch() {
        
    }
}
