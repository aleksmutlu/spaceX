//
//  DetailView.swift
//  Presentation
//
//  Created by Aleks Mutlu on 26.08.2022.
//

import UIKit

final class DetailView: NibView {
    
    // MARK: - Views
    
    @IBOutlet weak var headerView: CountryHeaderView!
    @IBOutlet weak var stackViewDetailSections: UIStackView!
    @IBOutlet weak var errorView: ErrorView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life cycle
    
    override func setUpViews() {
        super.setUpViews()
        
        setUp()
        setBottomContainerUp()
    }
    
    // MARK: - Setup
    
    private func setUp() {
        backgroundColor = Theme.mainBackgroundColor
    }
    
    private func setBottomContainerUp() {
        headerView.constraintImageViewBackgroundHeight.constant = 160
    }
}
