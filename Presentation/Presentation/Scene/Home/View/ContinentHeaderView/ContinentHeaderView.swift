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
    case loading
    
    var image: UIImage? {
        switch self {
        case .collapsed:
            return UIImage(systemName: "arrow.up.circle")
        case .expanded:
            return UIImage(systemName: "arrow.down.circle.fill")
        case .loading:
            return nil
        }
    }
}

final class ContinentHeaderView: NibView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonExpand: UIButton!
    
    override func setUpViews() {
        super.setUpViews()
        
        containerView.backgroundColor = Theme.contentBackgroundColor
        containerView.layer.cornerRadius = 16
    }
    
    func update(state: ContinentHeaderViewState) {
        switch state {
        case .collapsed:
            labelTitle.font = .systemFont(ofSize: 17, weight: .semibold)
            buttonExpand.configuration?.image = state.image
            contentView.backgroundColor = .clear
        case .expanded:
            labelTitle.font = .systemFont(ofSize: 20, weight: .black)
            buttonExpand.configuration?.image = state.image
            contentView.backgroundColor = Theme.contentBackgroundColor
        case .loading:
            break
        }
    }
}
