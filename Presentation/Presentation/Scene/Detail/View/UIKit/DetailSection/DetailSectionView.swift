//
//  DetailSectionView.swift
//  Presentation
//
//  Created by Aleks Mutlu on 27.08.2022.
//

import UIKit

final class DetailSectionView: NibView {
    
    // MARK: - Views
    
    @IBOutlet weak var sectionHeaderView: SectionHeaderView!
    @IBOutlet weak var labelContent: UILabel!
    
    func popuplate(with viewModel: DetailSectionViewModel) {
        sectionHeaderView.labelTitle.text = viewModel.sectionTitle
        labelContent.text = viewModel.detail
    }
}
