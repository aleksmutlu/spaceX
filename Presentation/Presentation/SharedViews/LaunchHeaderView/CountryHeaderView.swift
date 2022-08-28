//
//  CountryHeaderView.swift
//  Presentation
//
//  Created by Aleks Mutlu on 26.08.2022.
//

import UIKit

final class CountryHeaderView: NibView {
 
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var labelCountryName: UILabel!
    @IBOutlet weak var labelCapitalName: UILabel!
    @IBOutlet weak var labelPhoneCode: UILabel!
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
        labelCountryName.textColor = Theme.primaryText
    }
    
    private func setLabelRocketNameUp() {
        labelCapitalName.textColor = Theme.secondaryText
    }
    
    private func setContentViewUp() {
        contentView.backgroundColor = Theme.mainBackgroundColor
    }
    
    private func setBottomContainerViewUp() {
        bottomContainerView.backgroundColor = Theme.contentBackgroundColor
    }
}
