//
//  ContentView.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import SwiftUI
import SwiftData

struct ObjectiveListScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var objectives: [Objective]
    @State private var title: String = ""
    @State private var showAddObjective: Bool = false
    @State private var showEditObjective: Bool = false
    @State private var remark: String = ""
    
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(objectives) { objective in
                    NavigationLink {
                        Text("Objective at \(objective.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
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
                    HeaderView()
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
    }

    private func addObjective() {
        withAnimation {
            let newObjective = Objective(title: title, remark: remark, timestamp: Date())
            modelContext.insert(newObjective)
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
