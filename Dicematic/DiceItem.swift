//
//  DiceItem.swift
//  Dicematic
//
//  Created by Сергій Гашенко on 28.07.2022.
//

import SwiftUI

@MainActor class diceItem: ObservableObject {
    @Published var rolls: [Roll] = []
    @Published var item = Dice(sides: 6, value: 2)
}
