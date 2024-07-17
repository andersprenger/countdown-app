//
//  AddItemView.swift
//  CountdownApp
//
//  Created by Anderson Sprenger on 17/07/24.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDate = Date()
    var onAdd: (Date) -> Void

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Select Date and Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
            .navigationTitle("Add New Item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        onAdd(selectedDate)
                        dismiss()
                    }
                }
            }
        }
    }
}
