//
//  WavesModel.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 13/8/21.
//

import SwiftUI


//
// MARK: Ola (Figura)
//

struct Wave: Shape {

    var offset: Angle
    var percent: Double
    var waveHeightConstant: CGFloat
    
    var animatableData: AnimatablePair<Double, Double> {
        get { .init(offset.degrees, percent) }
        set {
            self.offset = Angle(degrees: newValue.first)
            self.percent = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()

        // empirically determined values for wave to be seen
        // at 0 and 100 percent
        let lowfudge = 0.02
        let highfudge = 0.98
        
        let newpercent = lowfudge + (highfudge - lowfudge) * percent
        let waveHeight = waveHeightConstant * rect.height
        let yoffset = CGFloat(1 - newpercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offset
        let endAngle = offset + Angle(degrees: 360)
        
        p.move(to: CGPoint(x: -300, y: yoffset + waveHeight * CGFloat(sin(offset.radians))))
        
        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * (rect.width + 300)
            p.addLine(to: CGPoint(x: x, y: yoffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }
        
        p.addLine(to: CGPoint(x: (rect.width + 300), y: rect.height))
        p.addLine(to: CGPoint(x: -300, y: rect.height))
        p.closeSubpath()
        
        return p
    }
}
