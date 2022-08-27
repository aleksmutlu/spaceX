//
//  DetailView.swift
//  Presentation
//
//  Created by Aleks Mutlu on 26.08.2022.
//

import UIKit

final class DetailView: NibView {
    
    @IBOutlet weak var headerView: CountryHeaderView!
    @IBOutlet weak var stackViewDetailSections: UIStackView!
    
    override func setUpViews() {
        super.setUpViews()
        
        setUp()
        setBottomContainerUp()
    }
    
    private func setUp() {
        backgroundColor = Theme.mainBackgroundColor
    }
    
    private func setBottomContainerUp() {
        headerView.constraintImageViewBackgroundHeight.constant = 160
    }
}
