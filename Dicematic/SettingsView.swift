//
//  SettingsView.swift
//  Dicematic
//
//  Created by Сергій Гашенко on 28.07.2022.
//

import SwiftUI

struct SettingsView: View {
    @State private var defaults = UserDefaults.standard
    @State private var sides = [4, 6, 8, 10, 12, 20, 100]
    @ObservedObject var dice: diceItem
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section("Number of dice sides:") {
                    Picker("Number of dice sides:", selection: $dice.item.sides) {
                        ForEach(sides, id: \.self) { num in
                            Text("\(num)-sided dice")
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save", action: save)
            }
        }
    }
    
    func save() {
        defaults.set(dice.item.sides, forKey: "Sides")
        dismiss()
    }
}
