//
//  DetailViewController.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import UIKit

public final class DetailViewController: BaseViewController {
    
    // MARK: - Views
    
    // MARK: - Properties
    
    private let viewModel: DetailViewModel
    
    // MARK: - Life cycle
    
    public init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
