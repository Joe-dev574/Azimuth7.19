//
//  HeaderView.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Daily")
                .font(.title3)
                .fontWeight(.bold)
                               .padding(.leading, 10)
                               .foregroundColor(.primary)
                               .offset(x: 7, y: -2)
            Text("Objectives")
                .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundStyle(.volsOrange)
            
            Spacer()
        }
        Spacer()
    }
}

#Preview {
    HeaderView()
}
