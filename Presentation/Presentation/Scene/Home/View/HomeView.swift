//
//  HomeView.swift
//  Presentation
//
//  Created by Aleks Mutlu on 24.08.2022.
//

import UIKit

final class HomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
//        print(imageViewBackground)
        backgroundColor = Theme.dimmedBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
//    lazy var imageViewBackground: UIImageView = {
//        let imageView = UIImageView(frame: bounds)
//        imageView.image = UIImage(named: "launchBackground2", in: Bundle.presentation, with: nil)
//        imageView.contentMode = .center
//        addSubview(imageView)
//        return imageView
//    }()
//
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        return tableView
    }()
}
