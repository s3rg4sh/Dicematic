//
//  DiceDot.swift
//  Dicematic
//
//  Created by Сергій Гашенко on 28.07.2022.
//

import SwiftUI

struct DiceDot: View {
    var body: some View {
        Image(systemName: "circle.fill")
            .resizable()
            .frame(width: 35, height: 35)
    }
}

struct DiceDot_Previews: PreviewProvider {
    static var previews: some View {
        DiceDot()
    }
}
