//
//  DetailViewController.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import RxSwift
import UIKit

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
     
        populateHeaderView()
    }
    
    private func bindViewModel() {
        viewModel.outputs.detailSection
            .observe(on: MainScheduler.instance)
            .bind { [weak self] viewModel in
                if let viewModel = viewModel {
                    self?.detailView.detailSectionView.popuplate(with: viewModel)
                } else {
                    self?.detailView.detailSectionView.isHidden = true
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func populateHeaderView() {
        detailView.headerView.labelMissionName.text = viewModel.outputs.headerData.missionName
        detailView.headerView.labelDate.text = viewModel.outputs.headerData.dateString
        detailView.headerView.labelRocketName.text = viewModel.outputs.headerData.rocketName
        detailView.headerView.imageViewPatch.kf.setImage(
            with: viewModel.outputs.headerData.patchImageURL
        )
    }
}
