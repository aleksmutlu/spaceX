//
//  CountryTableViewCell.swift
//  Presentation
//
//  Created by Aleks Mutlu on 24.08.2022.
//

import Kingfisher
import UIKit

final class CountryTableViewCell: UITableViewCell {

    // MARK: - Views
    
    @IBOutlet weak var headerView: CountryHeaderView!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setHeaderViewUp()
    }
    
    private func setHeaderViewUp() {
        headerView.layer.cornerRadius = Theme.containerCornerRadius
        headerView.layer.cornerCurve = .circular
    }

    // MARK: -
    
    func populate(with viewModel: CountryListItemViewModel) {
        headerView.labelCountryName.text = viewModel.name
        headerView.labelPhoneCode.text = viewModel.phone
        headerView.labelCapitalName.text = viewModel.capital
//        headerView.imageViewPatch.kf.setImage(with: viewModel.patchImageURL)
        headerView.labelFlag.text = viewModel.flag
//        headerView.layoutIfNeeded()
//        aaa.constant = headerView.frame.height
    }
}
