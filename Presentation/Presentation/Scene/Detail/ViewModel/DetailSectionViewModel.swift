//
//  DetailSectionViewModel.swift
//  Presentation
//
//  Created by Aleks Mutlu on 27.08.2022.
//

import Foundation

public struct DetailSectionViewModel {
    let sectionTitle: String
    let detail: String
    
    init(sectionTitle: String, detailItems: [String]) {
        self.sectionTitle = sectionTitle
        self.detail = detailItems.joined(separator: ", ")
    }
}
