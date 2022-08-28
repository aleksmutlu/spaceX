//
//  ContinentsDataSource.swift
//  Presentation
//
//  Created by Aleks Mutlu on 29.08.2022.
//

import UIKit

final class ContinentsDataSource: UITableViewDiffableDataSource<ContinentListItemViewModel, CountryListItemViewModel> {
    
    init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueCell(typed: CountryTableViewCell.self, indexPath: indexPath)
            cell.populate(with: item)
            return cell
        }
    }
}
