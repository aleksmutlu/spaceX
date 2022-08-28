//
//  CountryHeaderView.swift
//  Presentation
//
//  Created by Aleks Mutlu on 26.08.2022.
//

import UIKit

final class CountryHeaderView: NibView {
 
    // TODO: Remove patch, add flag bg
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageViewPatch: UIImageView!
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var labelMissionName: UILabel!
    @IBOutlet weak var labelRocketName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var dateContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var constraintImageViewBackgroundHeight: NSLayoutConstraint!
    @IBOutlet weak var labelFlag: UILabel!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabelMissionNameUp()
        setLabelRocketNameUp()
        setContentViewUp()
        setBottomContainerViewUp()
    }
    
    // MARK: - Setup
    
    private func setLabelMissionNameUp() {
        labelMissionName.textColor = Theme.primaryText
    }
    
    private func setLabelRocketNameUp() {
        labelRocketName.textColor = Theme.secondaryText
    }
    
    private func setContentViewUp() {
        contentView.backgroundColor = Theme.mainBackgroundColor
    }
    
    private func setBottomContainerViewUp() {
        bottomContainerView.backgroundColor = Theme.contentBackgroundColor
    }
}
