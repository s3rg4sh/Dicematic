//
//  DiceView.swift
//  Dicematic
//
//  Created by Сергій Гашенко on 28.07.2022.
//

import SwiftUI

struct DiceColor: Identifiable {
    let id: UUID
    let color: Color
}

struct DiceView: View {
    @State private var colorHue = 0.1
    @ObservedObject var dice: diceItem
    
    var value: Int
    
    var diceColors: [DiceColor] {
        [
            DiceColor(id: UUID(), color: Color(hue: max((colorHue - 0.1), 0.1), saturation: 1, brightness: 1)),
            DiceColor(id: UUID(), color: Color(hue: min((colorHue + 0.2), 1), saturation: 1, brightness: 1)),
            DiceColor(id: UUID(), color: Color(hue: max((colorHue - 0.4), 0.1), saturation: 1, brightness: 1)),
            DiceColor(id: UUID(), color: Color(hue: min((colorHue + 0.5), 1), saturation: 1, brightness: 1))
        ]
    }
    
    var body: some View {
        NavigationView {
            VStack {
            ZStack {
                if dice.item.sides > 6 {
                    Text("\(dice.item.value)")
                        .font(.system(size: 120))
                        .frame(width: 200, height: 200, alignment: .center)
                } else {
                    DiceDotsView(value: value)
                }
                
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder()
                    .overlay {
                        HStack(spacing: 0) {
                            ForEach(diceColors, id: \.id) { item in
                                item.color
                            }
                        }
                        .blur(radius: 20)
                        .mask(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 10)
                        )
                    }
                    .frame(width: 200, height: 200)
                    .onTapGesture {
                        withAnimation(.linear) {
                            colorHue = Double.random(in: 0.3...1.0)
                        }
                    }
            }
            Spacer(minLength: 95)
            }
        }
        .frame(width: 220, height: 220)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(dice: diceItem(), value: Dice.example.value)
    }
}
