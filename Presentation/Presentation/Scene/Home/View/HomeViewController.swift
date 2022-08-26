//
//  HomeViewController.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import UIKit
import RxSwift

public enum HomeState {
    case idle
    case loading
    case loadMore
    case display(launches: [LaunchListItemViewModel], animated: Bool, shouldResetOld: Bool)
    case error(title: String)
}

private typealias LaunchesDataSource = UITableViewDiffableDataSource<Int, LaunchListItemViewModel>
private let parallaxSpeed: CGFloat = 10

public final class HomeViewController: BaseViewController {
    
    // MARK: - Views
    
    private var homeView = HomeView(frame: UIScreen.main.bounds)
    
    // MARK: - Properties
    
    private let viewModel: HomeViewModel
    private lazy var dataSource: LaunchesDataSource = {
        let dataSource = LaunchesDataSource(tableView: homeView.tableView) { tableView, indexPath, viewModel in
            let cell = tableView.dequeueCell(typed: LaunchTableViewCell.self, indexPath: indexPath)
            cell.populate(with: viewModel)
            cell.imageViewBackground.image = UIImage(named: "bg\(indexPath.row % 4 + 1)", in: .presentation, compatibleWith: nil)
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
        viewModel.outputs.state
            .observe(on: MainScheduler.instance)
            .bind { [weak self] state in
                self?.updateUI(for: state)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.navigationBarTitle?
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        homeView.errorView.buttonRetry.rx.tap.asObservable()
            .bind { [weak self] in
                self?.viewModel.inputs.refetchTapped()
            }
            .disposed(by: disposeBag)
    }
    
    private func setTableViewUp() {
        homeView.tableView.dataSource = dataSource
        homeView.tableView.delegate = self
    }
    
    // MARK: - Helpers
    
    private func updateUI(for state: HomeState) {
        switch state {
        case .idle:
            displayIdle()
        case .loading:
            fatalError()
        case .loadMore:
            fatalError()
            
        case .display(let launches, let animated, let shouldResetOld):
            display(launchList: launches, animated: animated, shouldResetOld: shouldResetOld)
        case .error(let title):
            displayError(with: title)
        }
    }
    
    private func displayIdle() {
        homeView.errorView.isHidden = true
        homeView.tableView.isHidden = false
    }
    
    private func display(
        launchList: [LaunchListItemViewModel],
        animated: Bool,
        shouldResetOld: Bool
    ) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, LaunchListItemViewModel>()
        snapshot.appendSections([1])
        snapshot.appendItems(launchList, toSection: 1)
        dataSource.apply(snapshot, animatingDifferences: animated) {
            self.updateParallaxOffsets()
        }
    }
    
    private func displayError(with title: String?) {
        homeView.errorView.display(with: title)
        homeView.errorView.isHidden = false
        homeView.fadeIn()
        homeView.tableView.isHidden = true
        
        // TODO: Alert
    }
    
    private func updateParallaxOffset(of cell: LaunchTableViewCell, by contentOffsetY: CGFloat) {
        let yOffset = (contentOffsetY - cell.frame.origin.y) /
                       cell.imageViewBackground.frame.height * parallaxSpeed
                    
        cell.imageViewBackground.frame = cell.imageViewBackground.bounds.offsetBy(
            dx: 0,
            dy: yOffset
        )
    }
    
    private func updateParallaxOffsets(by contentOffsetY: CGFloat = 0) {
        guard let visibleCells = homeView.tableView.visibleCells as? [LaunchTableViewCell] else {
            return
        }
        for cell in visibleCells {
            updateParallaxOffset(of: cell, by: contentOffsetY)
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.didSelectItem(at: indexPath.row)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateParallaxOffsets(by: scrollView.contentOffset.y)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? LaunchTableViewCell else { return }
        updateParallaxOffset(of: cell, by: tableView.contentOffset.y)
    }
}
