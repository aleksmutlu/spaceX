//
//  LaunchTableViewCell.swift
//  Presentation
//
//  Created by Aleks Mutlu on 24.08.2022.
//

import Kingfisher
import UIKit

final class LaunchTableViewCell: UITableViewCell {

    // MARK: - Views
    
    @IBOutlet weak var headerView: LaunchHeaderView!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setHeaderViewUp()
    }
    
    private func setHeaderViewUp() {
        headerView.layer.cornerRadius = 16
        headerView.layer.cornerCurve = .circular
        headerView.constraintImageViewBackgroundHeight.constant = 100
    }

    // MARK: -
    
    func populate(with viewModel: LaunchListItemViewModel) {
        headerView.labelMissionName.text = viewModel.missionName
        headerView.labelDate.text = viewModel.dateString
        headerView.labelRocketName.text = viewModel.rocketName
        headerView.imageViewPatch.kf.setImage(with: viewModel.patchImageURL)
    }
}
