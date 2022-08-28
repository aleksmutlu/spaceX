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
        headerView.layer.cornerRadius = 16
        // TODO: Move 16 to constants, used in continentHeaderView
        headerView.layer.cornerCurve = .circular
        headerView.constraintImageViewBackgroundHeight.constant = 100
    }

    // MARK: -
    
    func populate(with viewModel: CountryListItemViewModel) {
        headerView.labelMissionName.text = viewModel.name
        headerView.labelDate.text = viewModel.phone
        headerView.labelRocketName.text = viewModel.capital
//        headerView.imageViewPatch.kf.setImage(with: viewModel.patchImageURL)
        headerView.labelFlag.text = viewModel.flag
        layoutIfNeeded()
    }
}
