//
//  HomeViewController.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import UIKit
import RxSwift

public typealias DisplayContinentsData = (viewModels: [ContinentListItemViewModel], activeSectionIndex: Int?)

public enum HomeHUDAction {
    case idle
    case showLoading
    case showError(title: String)
}

private let parallaxSpeed: CGFloat = 10
private let sectionHeaderHeight: CGFloat = 62

public final class HomeViewController: BaseViewController {
    
    // MARK: - Views
    
    private var homeView = HomeView(frame: UIScreen.main.bounds)
    
    // MARK: - Properties
    
    private let viewModel: HomeViewModel
    private var dataSource: ContinentsDataSource!
    
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
        
        setNavigationBarUp()
        
        dataSource = ContinentsDataSource(tableView: homeView.tableView)
        
        bindViewModel()
        
        viewModel.inputs.viewDidLoad()
    }
    
    // MARK: - Setup
    
    private func bindViewModel() {
        viewModel.outputs.hudAction
            .observe(on: MainScheduler.instance)
            .bind { [weak self] state in
                self?.handleHUDActions(for: state)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.displayContinents
            .observe(on: MainScheduler.instance)
            .bind { [weak self] viewModels, activeSectionIndex in
                self?.display(continents: viewModels, activeSectionIndex: activeSectionIndex)
            }
            .disposed(by: disposeBag)
        
        homeView.errorView.buttonRetry.rx.tap
            .bind { [weak self] in
                self?.viewModel.inputs.refetchTapped()
            }
            .disposed(by: disposeBag)
    }
    
    private func setTableViewUp() {
        homeView.tableView.dataSource = dataSource
        homeView.tableView.delegate = self
    }
    
    private func setNavigationBarUp() {
        navigationItem.title = viewModel.outputs.navigationBarTitle
    }
    
    // MARK: - Helpers
    
    private func handleHUDActions(for state: HomeHUDAction) {
        switch state {
        case .idle:
            displayIdle()
        case .showLoading:
            displayLoading()
        case .showError(let title):
            displayError(with: title)
        }
    }
    
    private func displayIdle() {
        homeView.errorView.isHidden = true
        homeView.tableView.isHidden = false
        homeView.activityIndicator.stopAnimating()
    }
    
    private func displayLoading() {
        homeView.activityIndicator.startAnimating()
        homeView.errorView.isHidden = true
        homeView.tableView.isHidden = true
    }
    
    private func display(
        continents: [ContinentListItemViewModel],
        activeSectionIndex: Int?
    ) {
        var snapshot = NSDiffableDataSourceSnapshot<ContinentListItemViewModel, CountryListItemViewModel>()
        
        for continent in continents {
            snapshot.appendSections([continent])
            snapshot.appendItems(continent.countryListItems, toSection: continent)
        }
        
        dataSource.apply(snapshot, animatingDifferences: false) {
            self.updateParallaxOffsets()
            
            if let activeSectionIndex = activeSectionIndex {
                self.expandSection(at: activeSectionIndex)
            } else {
                self.homeView.tableView.fadeIn(in: 0.4)
            }
        }
    }
    
    private func displayError(with title: String?) {
        homeView.errorView.display(with: title)
        homeView.errorView.isHidden = false
        homeView.fadeIn()
        homeView.tableView.isHidden = true
        homeView.activityIndicator.stopAnimating()
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
    
    private func expandSection(at index: Int) {
        homeView.tableView.scrollToRow(
            at: IndexPath(row: 0, section: index),
            at: .top,
            animated: false
        )
        let offset = homeView.tableView.contentOffset
        homeView.tableView.setContentOffset(CGPoint(x: 0, y: offset.y + 4), animated: false)
        
        homeView.tableView.visibleCells.enumerated().forEach { (offset, cell) in
            cell.transform = CGAffineTransform(translationX: 0, y: 120)
            UIView.animate(
                withDuration: 1,
                delay: TimeInterval(offset) * 0.02,
                usingSpringWithDamping: 0.85,
                initialSpringVelocity: 9,
                options: .curveEaseOut,
                animations: {
                    cell.transform = .identity
                },
                completion: nil
            )
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.countryTapped(at: indexPath.row)
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
    
    public func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        sectionHeaderHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ContinentHeaderView()
        let continentItem = dataSource.snapshot().sectionIdentifiers[section]
        headerView.labelTitle.text = continentItem.title
        let action = UIAction { [weak self] _ in
            self?.viewModel.inputs.continentTapped(at: section)
        }
        headerView.update(state: continentItem.state)
        headerView.buttonExpand.addAction(action, for: .touchUpInside)
        return headerView
    }
}
