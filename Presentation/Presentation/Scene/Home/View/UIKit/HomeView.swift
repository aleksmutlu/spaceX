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
            
        backgroundColor = Theme.mainBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.registerNibCell(typed: CountryTableViewCell.self)
        addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        return tableView
    }()
    
    lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(errorView)
        errorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        errorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        return errorView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.color = Theme.primaryText
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
}
