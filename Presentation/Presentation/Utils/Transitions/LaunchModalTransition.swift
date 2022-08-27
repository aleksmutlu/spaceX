//
//  LaunchModalTransition.swift
//  Presentation
//
//  Created by Aleks Mutlu on 27.08.2022.
//

import Foundation
import UIKit

final class LaunchModalTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let detailView = transitionContext.view(forKey: .to) as! DetailView
        let headerView = detailView.headerView
        
        let fromView = transitionContext.view(forKey: .from) as! HomeView
        let cell = fromView.tableView.visibleCells[2] as! CountryTableViewCell
        let sourceFrame = cell.headerView.globalFrame
        print(sourceFrame)
        
    }
}
