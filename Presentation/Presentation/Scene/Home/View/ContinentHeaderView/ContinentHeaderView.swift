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
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        containerView.backgroundColor = Theme.contentBackgroundColor
        containerView.layer.cornerRadius = 16
    }
    
    func update(state: ContinentHeaderViewState) {
        
        // TODO: FONT
        switch state {
        case .collapsed:
            labelTitle.font = .systemFont(ofSize: 17, weight: .semibold)
            buttonExpand.setImage(state.image, for: .normal)
        case .expanded:
            labelTitle.font = .systemFont(ofSize: 20, weight: .black)
            buttonExpand.setImage(state.image, for: .normal)
        case .loading:
            break
        }
    }
}
