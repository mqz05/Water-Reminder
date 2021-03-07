//
//  WiderDivisorHorizontal.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 06/03/2021.
//

import SwiftUI

struct WiderDivisorHorizontal: View {
    
    var color: Color = .gray
    var width: CGFloat = 5
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct WiderDivisorHorizontal_Previews: PreviewProvider {
    static var previews: some View {
        WiderDivisorHorizontal()
    }
}
