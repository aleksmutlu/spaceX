//
//  ContinentListItemViewModel.swift
//  Presentation
//
//  Created by Aleks Mutlu on 27.08.2022.
//

import Domain
import Foundation

public struct ContinentListItemViewModel: Hashable {
    let title: String
    let state: ContinentHeaderViewState
    var countryListItems: [CountryListItemViewModel] = []
}

extension ContinentListItemViewModel {
    
    init(continent: Continent, state: ContinentHeaderViewState) {
        title = continent.name
        self.state = state
        countryListItems = []
    }
}
