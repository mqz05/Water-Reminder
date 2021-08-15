//
//  WiderDivisorHorizontal.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 06/03/2021.
//

import SwiftUI



struct LineaCurva: Shape {
    func path(in rect: CGRect) -> Path {
        var linea = Path()
        linea.move(to: CGPoint(x: rect.minX, y: rect.midY))
        linea.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.midX, y: 600))
            
            
        return linea
    }
}

struct WiderDivisorHorizontal_Previews: PreviewProvider {
    static var previews: some View {
        LineaCurva()
    }
}
