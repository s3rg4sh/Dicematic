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
        switch value { //size: 145x145 px, dot: 35x35 px
        case 1:
            VStack {
                DiceDot()
            }
        case 2:
                VStack(spacing: 75) {
                    DiceDot()
                        .frame(width: 145, height: 35, alignment: .trailing)
                    
                    
                    DiceDot()
                        .frame(width: 145, height: 35, alignment: .leading)
                }
            
        case 3:
            VStack(spacing: 20) {
                DiceDot()
                    .frame(width: 145, height: 35, alignment: .trailing)
                
                DiceDot()
                
                DiceDot()
                    .frame(width: 145, height: 35, alignment: .leading)
            }
        case 4:
            VStack(spacing: 75) {
                HStack(spacing: 75) {
                    DiceDot()
                    DiceDot()
                }
                
                HStack(spacing: 75) {
                    DiceDot()
                    DiceDot()
                }
            }
        case 5:
            VStack(spacing: 20) {
                HStack(spacing: 75) {
                    DiceDot()
                    DiceDot()
                }
                
                DiceDot()
                
                HStack(spacing: 75) {
                    DiceDot()
                    DiceDot()
                }
            }
        case 6:
            VStack(spacing: 75) {
                HStack(spacing: 20) {
                    DiceDot()
                    DiceDot()
                    DiceDot()
                }
                
                HStack(spacing: 20) {
                    DiceDot()
                    DiceDot()
                    DiceDot()
                }
            }
        default:
            VStack(spacing: 75) {
                HStack(spacing: 20) {
                    DiceDot()
                    DiceDot()
                    DiceDot()
                }
                
                HStack(spacing: 20) {
                    DiceDot()
                    DiceDot()
                    DiceDot()
                }
            }
        
        }
    }
}

struct DiceDotsView_Previews: PreviewProvider {
    static var previews: some View {
        DiceDotsView(value: 3)
    }
}
