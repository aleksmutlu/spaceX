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
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageViewPatch: UIImageView!
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var labelMissionName: UILabel!
    @IBOutlet weak var labelRocketName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var dateContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabelMissionNameUp()
        setLabelRocketNameUp()
        setDateContainerViewUp()
        setContentViewUp()
        setBottomContainerViewUp()
        setContainerViewUp()
    }
    
    // MARK: - Setup
    
    private func setLabelMissionNameUp() {
        labelMissionName.textColor = Theme.primaryText
    }
    
    private func setLabelRocketNameUp() {
        labelRocketName.textColor = Theme.secondaryText
    }
    
    private func setDateContainerViewUp() {
        dateContainerView.backgroundColor = Theme.contentBackgroundColor
    }
    
    private func setContentViewUp() {
        contentView.backgroundColor = Theme.mainBackgroundColor
    }
    
    private func setBottomContainerViewUp() {
        bottomContainerView.backgroundColor = Theme.contentBackgroundColor
    }
    
    private func setContainerViewUp() {
        containerView.layer.cornerRadius = 16
        containerView.layer.cornerCurve = .circular
    }
    
    // MARK: -
    
    func populate(with viewModel: LaunchListItemViewModel) {
        labelMissionName.text = viewModel.missionName
        labelDate.text = viewModel.dateString
        labelRocketName.text = viewModel.rocketName
        imageViewPatch.kf.setImage(with: viewModel.patchImageURL)
        containerView.sendSubviewToBack(imageViewBackground)
    }
}
