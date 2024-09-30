//
//  SearchQueryView.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import SwiftUI
import SwiftData

struct SearchQueryView<Content: View>: View {
    init(searchText: String, @ViewBuilder content: @escaping ([Objective]) -> Content) {
        self.content = content
        
        let isSearchTextEmpty = searchText.isEmpty
        
        let predicate = #Predicate<Objective> {
            return isSearchTextEmpty || $0.title.localizedStandardContains(searchText)
        }
        
        _objectives = .init(filter: predicate, sort: [.init(\.timestamp, order: .reverse)], animation: .snappy(duration: 0.25, extraBounce: 0))
    }
    var content: ([Objective]) -> Content
    @Query var objectives: [Objective]
    var body: some View {
        content(objectives)
    }
}
