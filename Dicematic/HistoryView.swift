//
//  HistoryView.swift
//  Dicematic
//
//  Created by Сергій Гашенко on 28.07.2022.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var dice: diceItem
    @Environment(\.dismiss) var dismiss
    @State private var showConfirmation = false
    
    let generator = UINotificationFeedbackGenerator()
    
    var body: some View {
        NavigationView {
            if dice.rolls.isEmpty {
                Text("You didn't roll a dice!")
            } else {
                List {
                    ForEach(dice.rolls.reversed(), id: \.id) { roll in
                        Text("You rolled \(roll.value) at \(roll.date)")
                    }
                    .onDelete(perform: deleteItem)
                    .onDelete { _ in
                        Task {
                            await DataSave().writeJSON(dice.rolls)
                        }
                    }
                }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            }
        }
        .toolbar {
            Button {
                showConfirmation = true
                generator.notificationOccurred(.error)
            } label: {
                Image(systemName: "trash")
                    .tint(.red)
            }
        }
        .confirmationDialog("Are you sure?", isPresented: $showConfirmation) {
            Button("Clear History", role: .destructive) {
                clearHistory()
                generator.notificationOccurred(.success)
                Task {
                    await DataSave().writeJSON(dice.rolls)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
    }
    
    func clearHistory() {
        
        dice.rolls.removeAll()
    }
    
    func deleteItem(_ offset: IndexSet) {
        dice.rolls.remove(atOffsets: offset)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(dice: diceItem())
    }
}
