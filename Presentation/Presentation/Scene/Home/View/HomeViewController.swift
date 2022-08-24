//
//  HomeViewController.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import UIKit
import RxSwift

private typealias LaunchesDataSource = UITableViewDiffableDataSource<Int, LaunchListItemViewModel>

public final class HomeViewController: BaseViewController {
    
    // MARK: - Views
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.registerCell(typed: UITableViewCell.self)
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        return tableView
    }()
    
    // MARK: - Properties
    
    private let viewModel: HomeViewModel
    private lazy var dataSource: LaunchesDataSource = {
        let dataSource = LaunchesDataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueCell(typed: UITableViewCell.self, indexPath: indexPath)
            var config = cell.defaultContentConfiguration()
            config.text = item.missionName
            cell.contentConfiguration = config
            return cell
        }
        return dataSource
    }()
    
    
    // MARK: - Life cycle
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewDataSource()
        bindViewModel()
        
        viewModel.inputs.viewDidLoad()
    }
    
    // MARK: - Setup
    
    private func bindViewModel() {
        viewModel.outputs.launchItems
            .observe(on: MainScheduler.instance)
            .bind { [weak self] launchList in
                self?.display(launchList: launchList)
            }
            .disposed(by: disposeBag)
    }
    
    private func setTableViewDataSource() {
        tableView.dataSource = dataSource
    }
    
    // MARK: - Helpers
    
    func display(launchList: [LaunchListItemViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, LaunchListItemViewModel>()
        snapshot.appendSections([1])
        snapshot.appendItems(launchList, toSection: 1)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.didSelectItem(at: indexPath.row)
    }
}
