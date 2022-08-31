//
//  DetailViewModelWrapper.swift
//  Presentation
//
//  Created by Aleks Mutlu on 31.08.2022.
//

import Foundation
import RxSwift

public final class DetailViewModelWrapper: ObservableObject {
    
    private let viewModel: DetailViewModel?
    private let disposeBag = DisposeBag()
    
    @Published var header: CountryListItemViewModel!
    @Published var sections: [DetailSectionViewModel] = []
    
    public init(viewModel: DetailViewModel?) {
        self.viewModel = viewModel
        
        viewModel?.outputs.headerData
            .bind(onNext: { [weak self] headerViewModel in
                self?.header = headerViewModel
            })
            .disposed(by: disposeBag)
        
        viewModel?.outputs.detailSection
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] seciontViewModels in
                self?.sections = seciontViewModels
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - DetailViewModelInputs

extension DetailViewModelWrapper: DetailViewModelInputs {
    
    public func viewDidLoad() {
        viewModel?.inputs.viewDidLoad()
    }
    
    public func refetchTapped() {
        viewModel?.inputs.refetchTapped()
    }
}
