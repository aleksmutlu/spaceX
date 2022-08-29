//
//  DetailViewController.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import RxSwift
import UIKit

public enum DetailHUDActions {
    case idle
    case showLoading
    case showError(title: String)
}

public final class DetailViewController: BaseViewController {
    
    // MARK: - Views
        
    let detailView = DetailView(frame: UIScreen.main.bounds)
    
    // MARK: - Properties
    
    private let viewModel: DetailViewModel
    
    // MARK: - Life cycle
    
    public init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = detailView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        viewModel.inputs.viewDidLoad()
    }
    
    private func bindViewModel() {
        viewModel.outputs.detailSection
            .observe(on: MainScheduler.instance)
            .bind { [weak self] viewModels in
                self?.populateDetailSections(with: viewModels)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.headerData
            .observe(on: MainScheduler.instance)
            .bind { [weak self] viewModel in
                self?.populateHeaderView(with: viewModel)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.hudActions
            .observe(on: MainScheduler.instance)
            .bind { [weak self] action in
                self?.handleHUDActions(action)
            }
            .disposed(by: disposeBag)
        
        detailView.errorView.buttonRetry.rx.tap
            .bind { [weak self] in
                self?.viewModel.inputs.refetchTapped()
            }
            .disposed(by: disposeBag)
    }
    
    private func handleHUDActions(_ action: DetailHUDActions) {
        switch action {
        case .idle:
            detailView.errorView.isHidden = true
            detailView.activityIndicator.stopAnimating()
        case .showLoading:
            detailView.errorView.isHidden = true
            detailView.activityIndicator.startAnimating()
        case .showError(let title):
            detailView.errorView.display(with: title)
            detailView.errorView.isHidden = false
            detailView.activityIndicator.stopAnimating()
        }
    }
    
    private func populateHeaderView(with viewModel: CountryListItemViewModel) {
        detailView.headerView.labelCountryName.text = viewModel.name
        detailView.headerView.labelPhoneCode.text = viewModel.phone
        detailView.headerView.labelCapitalName.text = viewModel.capital
        detailView.headerView.labelFlag.text = viewModel.flag
    }
    
    private func populateDetailSections(with viewModels: [DetailSectionViewModel]) {
        for viewModel in viewModels {
            let detailSectionView = DetailSectionView()
            detailSectionView.translatesAutoresizingMaskIntoConstraints = false
            detailView.stackViewDetailSections.addArrangedSubview(detailSectionView)
            detailSectionView.popuplate(with: viewModel)
        }
    }
}
