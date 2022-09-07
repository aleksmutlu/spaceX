//
//  CountryTableViewCell.swift
//  Presentation
//
//  Created by Aleks Mutlu on 24.08.2022.
//

import UIKit
import RxSwift

final class CountryTableViewCell: UITableViewCell {

    // MARK: - Views
    
    @IBOutlet weak var headerView: CountryHeaderView!
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setHeaderViewUp()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    private func setHeaderViewUp() {
        headerView.layer.cornerRadius = Theme.containerCornerRadius
        headerView.layer.cornerCurve = .circular
        headerView.labelCountryName.numberOfLines = 1
    }

    // MARK: -
    
    func populate(with viewModel: CountryListItemViewModel) {
        headerView.labelCountryName.text = viewModel.name
        headerView.labelPhoneCode.text = viewModel.phone
        headerView.labelCapitalName.text = viewModel.capital
        headerView.labelFlag.text = viewModel.flag
        viewModel.temperature
            .map { "\($0)" }
            .asDriver(onErrorJustReturn: "-")
            .drive(headerView.labelPhoneCode.rx.text)
            .disposed(by: disposeBag)
    }
}
