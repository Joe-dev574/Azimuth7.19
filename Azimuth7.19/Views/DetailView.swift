//
//  DetailView.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import SwiftUI

struct DetailView: View {
    var size: CGSize
    var titleObjectiveSize: CGSize
    @State private var status = Status.Planning
    var animation: Namespace.ID
    @Bindable var objective: Objective
    /// View Properties
    @State private var animateLayers: Bool = false

    
    
    var body: some View {
        Rectangle()
            .fill(.background)
            .overlay(alignment: .topLeading) {
                TitleObjectiveView(size: titleObjectiveSize, objective: objective)
                    .blur(radius: animateLayers ? 100 : 0)
                    .opacity(animateLayers ? 0 : 1)
            }
            .overlay {
                ObjectiveContent()
            }
            .clipShape(.rect(cornerRadius: animateLayers ? 0 : 10))
            .matchedGeometryEffect(id: objective.id, in: animation)
            .transition(.offset(y: 1))
            .allowsHitTesting(objective.allowsHitTesting)
            .onChange(of: objective.allowsHitTesting, initial: true) { oldValue, newValue in
                withAnimation(objectiveAnimation) {
                    animateLayers = newValue
                }
            }
    }
    
    @ViewBuilder
    func ObjectiveContent() -> some View {
        GeometryReader {
            let currentSize: CGSize = $0.size
            VStack(alignment: .leading, spacing: 15) {
                TextField("Title of Objective...", text: $objective.title, axis: .vertical)
                    .font(.title)
                    .lineLimit(2)
                    .foregroundStyle(.primary)
                
                TextEditor(text: $objective.remark)
                    .font(.title3)
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
                    .overlay(alignment: .topLeading) {
                        if objective.remark.isEmpty {
                            Text("Briefly describe your objective...")
                                .font(.title3)
                                .foregroundStyle(.primary)
                                .offset(x: 8, y: 8)
                        }
                    }
                
            }
            .tint(.black)
            .padding(15)
            .padding(.top, safeArea.top)
            .frame(width: size.width, height: size.height)
            .frame(width: currentSize.width, height: currentSize.height, alignment: .topLeading)
        }
        .blur(radius: animateLayers ? 0 : 100)
        .opacity(animateLayers ? 1 : 0)
    }
    
    var safeArea: UIEdgeInsets {
        if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
            return safeArea
        }
        
        return .zero
    }
}
