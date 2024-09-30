//
//  ContentView.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import SwiftUI
import SwiftData



struct ObjectiveListScreen: View {
    /// View Properties
    @State private var searchText: String = ""
    @State private var selectedObjective: Objective?
    @State private var deleteObjective: Objective?
    @State private var animateView: Bool = false
    @FocusState private var isKeyboardActive: Bool
    @State private var titleObjectiveSize: CGSize = .zero
    @Namespace private var animation
    @Environment(\.modelContext) private var context
    
    @Environment(\.horizontalSizeClass) private var hClass
    
    var body: some View {
        NavigationSplitView {
            HeaderView()
            SearchQueryView(searchText: searchText) { objectives in
                ScrollView(.vertical) {
                    VStack(spacing: 20) {
                        SearchBar()
                       
                                LazyVGrid(columns: Array(repeating: GridItem(), count: hClass == .regular ? 4 : 2) ){
                                    ForEach(objectives) { objective in
                                        CardView(objective)
                                            .frame(height: 250)
                                            .onTapGesture {
                                                guard selectedObjective == nil && deleteObjective == nil else { return }
                                                isKeyboardActive = false
                                                
                                                selectedObjective = objective
                                                objective.allowsHitTesting = true
                                                withAnimation(objectiveAnimation) {
                                                    animateView = true
                                                }
                                            }
                                    }
                                }
                            }
#if os(macOS)
                            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
                          
#if os(iOS)
                                
#endif
                                
                       
                      
                }
                .safeAreaPadding(15)
                .overlay {
                    GeometryReader {
                        let size = $0.size
                        
                        ForEach(objectives) { objective in
                            if objective.id == selectedObjective?.id && animateView {
                                DetailView(
                                    size: size,
                                    titleObjectiveSize: titleObjectiveSize,
                                    animation: animation,
                                    objective: objective
                                )
                            }
                        }
                    }
                    .ignoresSafeArea(.container, edges: .top)
                }
                .safeAreaInset(edge: .bottom, spacing: 0) {
                    BottomBar()
                }
                .focused($isKeyboardActive)
            }
            } detail: {
                Text("Select an objective to view details.")
            }
        }
    
        /// Custom Search Bar With Some Basic Components
        @ViewBuilder
        func SearchBar() -> some View {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                
                TextField("Search", text: $searchText)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(Color.primary.opacity(0.06), in: .rect(cornerRadius: 10))
        }
        
        @ViewBuilder
        func CardView(_ objective: Objective) -> some View {
            ZStack {
                if selectedObjective?.id == objective.id && animateView {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(.clear)
                } else {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(.active)
                        .overlay {
                            TitleObjectiveView(size: titleObjectiveSize, objective: objective)
                        }
                        .matchedGeometryEffect(id: objective.id, in: animation)
                }
            }
            .onGeometryChange(for: CGSize.self) {
                $0.size
            } action: { newValue in
                titleObjectiveSize = newValue
            }
        }
        @ViewBuilder
        func BottomBar() -> some View {
            HStack(spacing: 15) {
                Group {
                    if !isKeyboardActive {
                        Button {
                            if selectedObjective == nil {
                                createEmptyObjective()
                            } else {
                                selectedObjective?.allowsHitTesting = false
                                deleteObjective = selectedObjective
                                withAnimation(noteAnimation.logicallyComplete(after: 0.1), completionCriteria: .logicallyComplete) {
                                    selectedObjective = nil
                                    animateView = false
                                } completion: {
                                    deleteObjectiveFromContext()
                                }
                            }
                        } label: {
                            Image(systemName: selectedObjective == nil ? "plus.circle.fill" : "trash.fill")
                                .font(.title2)
                                .foregroundStyle(selectedObjective == nil ? Color.primary : .red)
                                .contentShape(.rect)
                                .contentTransition(.symbolEffect(.replace))
                        }
                    }
                }
                
                Spacer(minLength: 0)
                
                ZStack {
                    if isKeyboardActive {
                        Button("Done") {
                            isKeyboardActive = false
                        }
                        .font(.title3)
                        .foregroundStyle(Color.primary)
                        .transition(.blurReplace)
                    }
                    
                    if selectedObjective != nil && !isKeyboardActive {
                        Button {
                            selectedObjective?.allowsHitTesting = false
                            
                            if let selectedObjective, (selectedObjective.title.isEmpty && selectedObjective.remark.isEmpty) {
                                deleteObjective = selectedObjective
                            }
                            
                            withAnimation(noteAnimation.logicallyComplete(after: 0.1), completionCriteria: .logicallyComplete) {
                                animateView = false
                                selectedObjective = nil
                            } completion: {
                                deleteObjectiveFromContext()
                            }
                        } label: {
                            Image(systemName: "square.grid.2x2.fill")
                                .font(.title3)
                                .foregroundStyle(Color.primary)
                                .contentShape(.rect)
                        }
                        .transition(.blurReplace)
                    }
                }
            }
            .overlay {
                Text("Objectives")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .opacity(selectedObjective != nil ? 0 : 1)
            }
        }
    
        func createEmptyObjective() {
            let colors: [String] = (1...5).compactMap({ "Objective \($0)" })
            _ = colors.randomElement()!
            let objective = Objective(title: .init(), remark: "", timestamp: Date.now, dateStarted: .init(), dateCompleted: .init(), defineObstacle: "", priority: nil, status: .Active)
            context.insert(objective)
            Task {
                try? await Task.sleep(for: .seconds(0))
                selectedObjective = objective
                selectedObjective?.allowsHitTesting = true
                
                withAnimation(noteAnimation) {
                    animateView = true
                }
            }
        }
        
        func deleteObjectiveFromContext() {
            if let deleteObjective {
                context.delete(deleteObjective)
                try? context.save()
                self.deleteObjective = nil
            }
        }
    }


#Preview {
    ObjectiveListScreen()
        .modelContainer(for: Objective.self, inMemory: true)
}
