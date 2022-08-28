//
//  HomeViewController.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import UIKit
import RxSwift

// TODO: move
class GenericTableDataSource: UITableViewDiffableDataSource<ContinentListItemViewModel, CountryListItemViewModel> {
  init(tableView: UITableView) {
    super.init(tableView: tableView) { tableView, indexPath, item in
        let cell = tableView.dequeueCell(typed: CountryTableViewCell.self, indexPath: indexPath)
        cell.populate(with: item)
      return cell
    }
  }
}

public enum HomeState {
    case idle
    case loading
    case loadMore
    case display(continents: [ContinentListItemViewModel], action: DisplayAction)
    case error(title: String)
    
    public enum DisplayAction {
        case expand(index: Int)
        case collapse
    }
}

private let parallaxSpeed: CGFloat = 10

public final class HomeViewController: BaseViewController {
    
    // MARK: - Views
    
    private var homeView = HomeView(frame: UIScreen.main.bounds)
    
    // MARK: - Properties
    
    private let viewModel: HomeViewModel
    private var dataSource: GenericTableDataSource!
    
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
        
        dataSource = GenericTableDataSource(tableView: homeView.tableView)
        
        bindViewModel()
        
        viewModel.inputs.viewDidLoad()
        
        navigationController?.transitioningDelegate = self
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
        case .display(let continents, let action):
            display(continents: continents, action: action)
        case .error(let title):
            displayError(with: title)
        }
    }
    
    private func displayIdle() {
        homeView.errorView.isHidden = true
        homeView.tableView.isHidden = false
    }
    
    private func display(
        continents: [ContinentListItemViewModel],
        action: HomeState.DisplayAction
    ) {
        var snapshot = NSDiffableDataSourceSnapshot<ContinentListItemViewModel, CountryListItemViewModel>()
        
        for continent in continents {
            snapshot.appendSections([continent])
            snapshot.appendItems(continent.countryListItems, toSection: continent)
        }
        
        dataSource.apply(snapshot, animatingDifferences: false) {
            self.updateParallaxOffsets()
            // TODO: Divide animations into two methods
            switch action{
            case .expand(let index):
                self.homeView.tableView.scrollToRow(
                    at: IndexPath(row: 0, section: index),
                    at: .top,
                    animated: false
                )
                
                self.homeView.tableView.visibleCells.enumerated().forEach { (offset, cell) in
                    cell.transform = CGAffineTransform(translationX: 0, y: 120)
                    UIView.animate(
                        withDuration: 1,
                        delay: TimeInterval(offset) * 0.02,
                        usingSpringWithDamping: 0.85,
                        initialSpringVelocity: 9,
                        options: .curveEaseIn,
                        animations: {
                            cell.transform = .identity
                        },
                        completion: nil
                    )
                }
            case .collapse:
                self.homeView.tableView.fadeIn(in: 0.4)
            }
        }
    }
    
    private func displayError(with title: String?) {
        homeView.errorView.display(with: title)
        homeView.errorView.isHidden = false
        homeView.fadeIn()
        homeView.tableView.isHidden = true
        
        // TODO: Alert
    }
    
    private func updateParallaxOffset(of cell: CountryTableViewCell, by contentOffsetY: CGFloat) {
        let yOffset = (contentOffsetY - cell.frame.origin.y) /
        cell.headerView.imageViewBackground.frame.height * parallaxSpeed
                    
        cell.headerView.imageViewBackground.frame = cell.headerView.imageViewBackground.bounds.offsetBy(
            dx: 0,
            dy: yOffset
        )
    }
    
    private func updateParallaxOffsets(by contentOffsetY: CGFloat = 0) {
        guard let visibleCells = homeView.tableView.visibleCells as? [CountryTableViewCell] else {
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
    
    public func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        guard let cell = cell as? CountryTableViewCell else { return }
        updateParallaxOffset(of: cell, by: tableView.contentOffset.y)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        62
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ContinentHeaderView()
        let continentItem = dataSource.snapshot().sectionIdentifiers[section]
        headerView.labelTitle.text = continentItem.title
        let action = UIAction { [weak self] _ in
            self?.viewModel.inputs.expandTapped(at: section)
        }
        headerView.update(state: continentItem.state)
        headerView.buttonExpand.addAction(action, for: .touchUpInside)
        headerView.layer.zPosition = CGFloat(section) * 0.1
        return headerView
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LaunchModalTransition()
    }
}
