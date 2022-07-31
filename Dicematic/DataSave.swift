//
//  WriteToFile.swift
//  Dicematic
//
//  Created by Сергій Гашенко on 29.07.2022.
//

import SwiftUI
import UIKit

struct DataSave {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let fileName = "rollsHistory.json"
    
    func writeJSON(_ object: [Roll]) async {
        do {
            let directory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let filePath = directory.appendingPathComponent(fileName)
    
            try encoder.encode(object).write(to: filePath)

        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadJSON() async -> [Roll] {
            do {
                let directory = try FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let filePath = directory.appendingPathComponent(fileName)

                let data = try Data(contentsOf: filePath)
                let rolls = try decoder.decode([Roll].self, from: data)
                    
                return rolls
            } catch {
                print(error.localizedDescription)
                return []
            }
    }
    
}
