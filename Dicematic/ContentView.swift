//
//  ContentView.swift
//  Dicematic
//
//  Created by Сергій Гашенко on 28.07.2022.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    @State private var defaults = UserDefaults.standard
    @StateObject private var dice = diceItem()
    @State private var settingsIsShowing = false
    @State private var engine: CHHapticEngine?
    @State private var rotationDegrees = 0
    @State private var colorHue = 0.3
    
    let generator = UINotificationFeedbackGenerator()
    
    
var body: some View {
    NavigationView {
            DiceView(dice: dice, colorHue: colorHue, value: dice.item.value)
                .onTapGesture {
                    diceFall()
                    
                    dice.item.value = Int.random(in: 1...dice.item.sides)
                    
                    dice.rolls.append(Roll(id: UUID(), value: dice.item.value, date: time()))
                    
                    Task {
                        await DataSave().writeJSON(dice.rolls)
                    }
                    
                    withAnimation(.linear(duration: 1)) {
                         colorHue = Double.random(in: 0.1...1.0)
                    }
                    
                    withAnimation(.spring()) {
                        rotationDegrees == 360 ? (rotationDegrees -= 360) : (rotationDegrees += 360)
                    }
                }
            .rotation3DEffect(.degrees(Double(rotationDegrees)), axis: (x: 0, y: 1, z: 0))
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
            .onChange(of: rotationDegrees) { newValue in
                if newValue == 180 {
                    dice.item.value = Int.random(in: 1...dice.item.sides)
                }
            }
        }
        .sheet(isPresented: $settingsIsShowing) { SettingsView(dice: dice) }
        .onAppear {
            prepareHaptics()
            
            if let sides = defaults.value(forKey: "Sides") { dice.item.sides = sides as! Int }
            
            Task {
                await dice.rolls = DataSave().loadJSON()
            }
            
        }
    }
    
    func diceFall() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0.1)
        events.append(event)

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
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
