//
//  WiderDivisorVertical.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 06/03/2021.
//

import SwiftUI

struct WiderDivisorVertical: View {
    
    var color: Color = .gray
    var width: CGFloat = 5
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width)
            .edgesIgnoringSafeArea(.vertical)
    }
}

struct WiderDivisorVertical_Previews: PreviewProvider {
    static var previews: some View {
        WiderDivisorVertical()
    }
}
