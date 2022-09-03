//
//  HomeSwiftUIView.swift
//  Presentation
//
//  Created by Aleks Mutlu on 1.09.2022.
//

import SwiftUI

public struct HomeSwiftUIView: View {
    
    @ObservedObject var viewModel: HomeViewModelWrapper
    
    let gridItems: [GridItem] = [.init(.flexible())]
    
    public init(viewModel: HomeViewModelWrapper) {
        self.viewModel = viewModel
        
        viewModel.viewDidLoad()
    }
    
    public var body: some View {
        List(Array(viewModel.continents.enumerated()), id: \.offset) { (sectionIndex, continentViewModel) in
            Section {
                ForEach(Array(continentViewModel.countryListItems.enumerated()), id: \.offset) { rowIndex, countryViewModel in
                    CountrySummaryView(imageHeight: 116, country: countryViewModel)
                        .cornerRadius(16)
                        .listRowBackground(Color(.mainBackground))
                        .listRowSeparator(.hidden)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                        .onTapGesture {
                            viewModel.countryTapped(at: rowIndex)
                        }
                }
            } header: {
                ContinentView(viewModel: continentViewModel) {
                    viewModel.continentTapped(at: sectionIndex)
                }
                .frame(height: 62)
                .background(Color(.contentBackground))
                .cornerRadius(16)
            }
            .background(Color.clear)
        }
        .background(Color(.mainBackground))
        .listStyle(.plain)
    }
}

struct HomeSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModelWrapper(viewModel: nil)
        viewModel.continents = [
            .init(
                title: "Asia",
                state: .collapsed,
                countryListItems: [
                    .init(name: "Turkey", capital: "Ankara", flag: "🇹🇷", phone: "+90"),
                    .init(name: "Turkey2", capital: "Ankara", flag: "🇹🇷", phone: "+90"),
                    .init(name: "Turkey3", capital: "Ankara", flag: "🇹🇷", phone: "+90"),
                    .init(name: "Turkey4", capital: "Ankara", flag: "🇹🇷", phone: "+90")
                ]
            ),
            .init(
                title: "Asia",
                state: .collapsed,
                countryListItems: [
                    .init(name: "Turkey", capital: "Ankara", flag: "🇹🇷", phone: "+90"),
                    .init(name: "Turkey2", capital: "Ankara", flag: "🇹🇷", phone: "+90"),
                    .init(name: "Turkey3", capital: "Ankara", flag: "🇹🇷", phone: "+90"),
                    .init(name: "Turkey4", capital: "Ankara", flag: "🇹🇷", phone: "+90")
                ]
            )
        ]
        let view = HomeSwiftUIView(viewModel: viewModel)
            .preferredColorScheme(.dark)
        return view
    }
}
