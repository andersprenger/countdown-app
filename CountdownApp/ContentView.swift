//
//  ContentView.swift
//  CountdownApp
//
//  Created by Anderson Sprenger on 17/07/24.
//

import SwiftUI
import SwiftData
import Combine

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var showingAddItemView = false
    @State private var timer: Timer?
    @State private var currentDate = Date()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        VStack {
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            Text(timeDifferenceString(from: item.timestamp))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    } label: {
                        VStack(alignment: .leading) {
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                            Text(timeDifferenceString(from: item.timestamp))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { showingAddItemView = true }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Countdown")
        }
        .sheet(isPresented: $showingAddItemView) {
            AddItemView { date in
                addItem(date: date)
            }
        }
        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
    }
}

extension ContentView {
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            currentDate = Date()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func addItem(date: Date) {
        withAnimation {
            let newItem = Item(timestamp: date)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }

    private func timeDifferenceString(from date: Date) -> String {
        let components = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: date)
        return String(format: "%02dd %02dh %02dm %02ds", components.day ?? 0, components.hour ?? 0, components.minute ?? 0, components.second ?? 0)
    }
}
