//
//  ContentView.swift
//  Dicematic
//
//  Created by Сергій Гашенко on 28.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var defaults = UserDefaults.standard
    @StateObject private var dice = diceItem()
    @State private var settingsIsShowing = false
    
    
var body: some View {
    NavigationView {
        DiceView(dice: dice, value: dice.item.value)
            .onTapGesture {
                dice.item.value = Int.random(in: 1...dice.item.sides)
                dice.rolls.append(Roll(id: UUID(), value: dice.item.value, date: time()))
                Task {
                    await DataSave().writeJSON(dice.rolls)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        HistoryView(dice: dice)
                    } label: {
                        Image(systemName: "list.bullet.rectangle.portrait")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 65)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        settingsIsShowing = true
                    } label: {
                        Image(systemName: "gearshape.2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 65)
                            
                    }
                }
            }
        }
        .sheet(isPresented: $settingsIsShowing) { SettingsView(dice: dice) }
        .onAppear {
            if let sides = defaults.value(forKey: "Sides") { dice.item.sides = sides as! Int }
            Task {
                await dice.rolls = DataSave().loadJSON()
            }
        }
    }
    
    func time() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        return formatter.string(from: Date.now)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
