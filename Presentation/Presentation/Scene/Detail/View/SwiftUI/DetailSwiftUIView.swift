//
//  DetailSwiftUIView.swift
//  Presentation
//
//  Created by Aleks Mutlu on 30.08.2022.
//

import SwiftUI

public struct DetailSwiftUIView: View {
    
    @ObservedObject var viewModel: DetailViewModelWrapper
    
    public init(viewModel: DetailViewModelWrapper) {
        self.viewModel = viewModel
        
        viewModel.viewDidLoad()
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                CountrySummaryView(
                    imageHeight: 160,
                    country: viewModel.header
                )
                ForEach(viewModel.sections, id: \.sectionTitle) { section in
                    GroupBox(section.sectionTitle) {
                        HStack {
                            Text(section.detail)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                    }
                }
            }
        }
        .background(Color(.mainBackground))
        .ignoresSafeArea(.container, edges: .top)
        
    }
}

struct DetailSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DetailViewModelWrapper(viewModel: nil)
        viewModel.sections = [
            .init(sectionTitle: "Languages", detailItems: ["Turkish"]),
            .init(sectionTitle: "States", detailItems: ["Istanbul", "Ankara"])
        ]
        let view = DetailSwiftUIView(viewModel: viewModel)
            .preferredColorScheme(.dark)
        return view
    }
}
 
