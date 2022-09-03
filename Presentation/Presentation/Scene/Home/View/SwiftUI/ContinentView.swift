//
//  ContinentView.swift
//  Presentation
//
//  Created by Aleks Mutlu on 1.09.2022.
//

import SwiftUI

struct ContinentView: View {
    
    private let viewModel: ContinentListItemViewModel
    private let onExpandTapped: (() -> Void)?
    
    init(viewModel: ContinentListItemViewModel, onExpandTapped: (() -> Void)?) {
        self.viewModel = viewModel
        self.onExpandTapped = onExpandTapped
    }
    
    var body: some View {
        HStack {
            Text(viewModel.title)
                .font(.system(size: 20))
            Button {
                onExpandTapped?()
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: viewModel.state.imageStringName)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        }
        .padding()
    }
}

struct ContinentView_Previews: PreviewProvider {
    static var previews: some View {
        ContinentView(
            viewModel: ContinentListItemViewModel(
                title: "Asia",
                state: .collapsed
            ),
            onExpandTapped: nil
        )
        .previewLayout(.fixed(width: 300, height: 62))
    }
}
