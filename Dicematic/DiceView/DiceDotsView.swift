//
//  DiceDotsView.swift
//  Dicematic
//
//  Created by Сергій Гашенко on 28.07.2022.
//

import SwiftUI

struct DiceDotsView: View {
     var value: Int
    
    var body: some View {
        switch value {
        case 1:
            VStack {
                DiceDot()
            }
        case 2:
                VStack {
                    DiceDot()
                        .offset(x: 60, y: -40)
                    
                    
                    DiceDot()
                        .offset(x: -60, y: 40)
                }
            
        case 3:
                VStack {
                    DiceDot()
                        .offset(x: 60, y: -20)
                    
                    DiceDot()
                        .offset(x: 0, y: 0)
                    
                    DiceDot()
                        .offset(x: -60, y: 20)
                }
        case 4:
            VStack {
                DiceDot()
                    .offset(x: 60, y: 5)
                
                DiceDot()
                    .offset(x: 60, y: 80)
                
                DiceDot()
                    .offset(x: -60, y: -80)
                
                DiceDot()
                    .offset(x: -60, y: -5)
            }
        case 5:
            VStack {
                DiceDot()
                    .offset(x: 60, y: 20)
                
                DiceDot()
                    .offset(x: -60, y: -20)
                
                DiceDot()
                    .offset(x: 0, y: 0)
                
                DiceDot()
                    .offset(x: 60, y: 20)
                
                DiceDot()
                    .offset(x: -60, y: -20)
            }
        case 6:
            VStack {
                DiceDot()
                    .offset(x: 60, y: 50)
                
                DiceDot()
                    .offset(x: 0, y: 7)
                
                DiceDot()
                    .offset(x: -60, y: -36)
                
                
                
                DiceDot()
                    .offset(x: 60, y: 30)
                
                DiceDot()
                    .offset(x: 0, y: -13)
                
                DiceDot()
                    .offset(x: -60, y: -56)
            }
        default:
            VStack {
                Image(systemName: "circle.xmark")
                    .tint(.red)
            }
        
        }
    }
}
