//
//  ContinentHeaderView.swift
//  Presentation
//
//  Created by Aleks Mutlu on 27.08.2022.
//

import UIKit

enum ContinentHeaderViewState {
    case collapsed
    case expanded
    
    var image: UIImage? {
        switch self {
        case .collapsed:
            return UIImage(systemName: "arrow.up.circle")
        case .expanded:
            return UIImage(systemName: "arrow.down.circle.fill")
        }
    }
}

final class ContinentHeaderView: NibView {
    
    // MARK: - Views
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonExpand: UIButton!
    
    // MARK: - Setup
    
    override func setUpViews() {
        super.setUpViews()
        
        setContainerViewUp()
    }
    
    private func setContainerViewUp() {
        containerView.backgroundColor = Theme.contentBackgroundColor
        containerView.layer.cornerRadius = Theme.containerCornerRadius
    }
    
    func update(state: ContinentHeaderViewState) {
        switch state {
        case .collapsed:
            labelTitle.font = .systemFont(ofSize: 17, weight: .semibold)
            buttonExpand.configuration?.image = state.image
        case .expanded:
            labelTitle.font = .systemFont(ofSize: 20, weight: .black)
            buttonExpand.configuration?.image = state.image
        }
    }
}
