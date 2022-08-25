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
    
    private var homeView = HomeView(frame: UIScreen.main.bounds)
    
    // MARK: - Properties
    
    private let viewModel: HomeViewModel
    private lazy var dataSource: LaunchesDataSource = {
        let dataSource = LaunchesDataSource(tableView: homeView.tableView) { tableView, indexPath, viewModel in
            let cell = tableView.dequeueCell(typed: LaunchTableViewCell.self, indexPath: indexPath)
            cell.populate(with: viewModel)
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
    
    public override func loadView() {
        view = homeView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewUp()
        
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
    
    private func setTableViewUp() {
        homeView.tableView.registerNibCell(typed: LaunchTableViewCell.self)
        homeView.tableView.dataSource = dataSource
        homeView.tableView.delegate = self
    }
    
    // MARK: - Helpers
    
    private func display(launchList: [LaunchListItemViewModel]) {
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
