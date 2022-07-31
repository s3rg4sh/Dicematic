//
//  Dice.swift
//  Dicematic
//
//  Created by Сергій Гашенко on 28.07.2022.
//

import SwiftUI

struct Dice {
    var sides: Int
    var value: Int
    
    static var example = Dice(sides: 6, value: 5)
}

struct Roll: Codable, Identifiable {
    let id: UUID
    let value: Int
    let date: String
    
    static var example = Roll(id: UUID(), value: 2, date: Date.now.formatted(date: .omitted, time: .shortened))
}
