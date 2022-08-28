//
//  ErrorView.swift
//  Presentation
//
//  Created by Aleks Mutlu on 26.08.2022.
//

import UIKit

enum ErrorViewState {
    case visible(title: String)
    case hidden
}

// MARK: - Constants

private let imageHeightWidth: CGFloat = 120

final class ErrorView: NibView {
  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonRetry: UIButton!
    
    // MARK: - Setup
    
    override func setUpViews() {
        super.setUpViews()
        
        setImageViewUp()
        setLabelTitleUp()
    }
    
    private func setImageViewUp() {
        imageView.layer.cornerRadius = imageHeightWidth / 2
        imageView.clipsToBounds = true
    }
    
    private func setLabelTitleUp() {
        labelTitle.font = .systemFont(ofSize: 15)
        labelTitle.textColor = Theme.secondaryText
    }
    
    func display(with title: String?) {
        labelTitle.text = title
    }
}
