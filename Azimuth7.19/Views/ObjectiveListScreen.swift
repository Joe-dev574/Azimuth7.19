//
//  ContentView.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import SwiftUI
import SwiftData


enum SortOrder: String, Identifiable, CaseIterable {
    case status, title, remark
    
    var id: Self {
        self
    }
}
struct ObjectiveListScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var objectives: [Objective]
    @State private var title: String = ""
    @State private var showAddObjectiveSheet: Bool = false
    @State private var showEditObjective: Bool = false
    @State private var remark: String = ""
    /// View Properties
    @State private var searchText: String = ""
    @State private var selectedNote: Note?
    @State private var deleteNote: Note?
    @State private var animateView: Bool = false
    @FocusState private var isKeyboardActive: Bool
    @State private var titleNoteSize: CGSize = .zero
    @Namespace private var animation
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(objectives) { objective in
                    NavigationLink {
                        Text("Objective at \(objective.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        ///ObjectiveCard with Details
                        Text(objective.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteObjectives)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .principal) {
                    HeaderView().padding(.horizontal,1)
                }
#endif
                ToolbarItem {
                    Button(action: addObjective) {
                        Label("Add Objective", systemImage: "plus")
                      
                    }
                }
            }
        } detail: {
            Text("Select an objective to view details.")
        }
        .sheet(isPresented: $showAddObjectiveSheet) {
         
            AddObjectiveView()
                .presentationDetents([.height(350)])
        }
    }
        private func addObjective() {
            HapticManager.notification(type: .success)
            withAnimation {
                showAddObjectiveSheet = true

            }
        }
        
        private func deleteObjectives(offsets: IndexSet) {
            withAnimation {
                for index in offsets {
                    modelContext.delete(objectives[index])
                }
            }
        }
    }

#Preview {
    ObjectiveListScreen()
        .modelContainer(for: Objective.self, inMemory: true)
}
