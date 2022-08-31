//
//  CountrySummaryView.swift
//  Presentation
//
//  Created by Aleks Mutlu on 30.08.2022.
//

import SwiftUI

struct CountrySummaryView: View {
    
    let country: CountryListItemViewModel
    let imageHeight: CGFloat
    
    init(imageHeight: CGFloat, country: CountryListItemViewModel) {
        self.imageHeight = imageHeight
        self.country = country
    }
    
    var body: some View {
        VStack {
            ZStack {
                Image("staticmap", bundle: .presentation)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: imageHeight)
                    .aspectRatio(375 / 100, contentMode: .fit)
                    .clipped()
                if let flag = country.flag {
                    HStack {
                        Text(flag)
                            .font(.system(size: 70))
                        Spacer()
                    }
                    .padding()
                }
            }
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(country.name)
                        .foregroundColor(Color(.primaryText))
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(.max)
                    if let capital = country.capital {
                        Text(capital)
                            .foregroundColor(Color(.secondayText))
                        
                    }
                }
                Spacer()
                if let phoneCode = country.phone {
                    Text(phoneCode)
                        .foregroundColor(Color(.primaryText))
                }
            }
            .padding()
        }
        .background(Color(.contentBackground))
    }
}

extension Color {
    
    init(_ color: Theme.Color) {
        self.init(color.asUIColor)
    }
    
    init(inPresentation name: String) {
        self.init(name, bundle: .presentation)
    }
    
    static func convert(_ color: Color) -> UIColor {
        return UIColor(color)
    }
}

struct CountrySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        CountrySummaryView(
            imageHeight: 100,
            country: CountryListItemViewModel(
                name: "Turkey",
                capital: "Ankara",
                flag: "🇹🇷",
                phone: "+90"
            )
        )
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/))
    }
}
