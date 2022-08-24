//
//  UITableView+Extensions.swift
//  Presentation
//
//  Created by Aleks Mutlu on 24.08.2022.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(typed cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: String(describing: cellType))
    }
    
    func dequeueCell<T: UITableViewCell>(typed cellType: T.Type, indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as! T
    }
}
