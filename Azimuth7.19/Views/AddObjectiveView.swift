//
//  AddObjectiveView.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import SwiftUI

struct AddObjectiveView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var remark = ""
    var body: some View {
        NavigationStack {
            VStack{
                Divider()
                    .padding()
                TextField("Objective Title...", text: $title)
                    .padding()
                    .background(Color.gray.opacity(0.2).cornerRadius(7.5))
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                  
                TextField("Brief Description", text: $remark)
                    .padding()
                .background(Color.gray.opacity(0.2).cornerRadius(7.5))
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.horizontal, 15)
                .padding(.vertical,5)
            }
            .padding(.horizontal)
            Spacer()
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .primaryAction){
                    Button("Save") {
                                       let newObjective = Objective(title: title, remark: remark, timestamp: Date())
                                        modelContext.insert(newObjective)
                                    dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(title.isEmpty || remark.isEmpty)
                }
            }
                .navigationTitle("Add New Objective")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
    
#Preview {
    AddObjectiveView()
}
