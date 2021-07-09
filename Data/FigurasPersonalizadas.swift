//
//  FigurasPersonalizadas.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 01/07/2021.
//

import SwiftUI

struct EsquinasRedondeadas: Shape {
    
    var esquinas: UIRectCorner
    var radio: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: esquinas, cornerRadii: CGSize(width: radio, height: radio))
        
        return Path(path.cgPath)
    }
}


struct WiderDivisorHorizontal: View {
    
    var color: Color = .gray
    var width: CGFloat = 5
    var height: CGFloat = .infinity
    var opacity: Double = 1
    
    var body: some View {
        Rectangle()
            .fill(color)
            .opacity(opacity)
            .frame(width: height, height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}


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


struct BotonTresLineas: View {
    
    var body: some View {
        
        VStack(spacing: 5) {
            Capsule()
                .fill(Color.white)
                .frame(width: 30, height: 3)
            Capsule()
                .fill(Color.white)
                .frame(width: 30, height: 3)
            Capsule()
                .fill(Color.white)
                .frame(width: 30, height: 3)
        }
    }
}


struct BotonCruz: View {
    
    var body: some View {
        
        VStack(spacing: 5) {
            Capsule()
                .fill(Color.white)
                .frame(width: 35, height: 3)
                .rotationEffect(.init(degrees: -45))
                .offset(x: 0, y: 8)
            
            
            Capsule()
                .fill(Color.white)
                .frame(width: 35, height: 3)
                .rotationEffect(.init(degrees: 45))
            
        }
    }
}

/*
struct FigurasPersonalizadas_Previews: PreviewProvider {
    static var previews: some View {
        BotonTresLineas()
    }
}
*/
/*
 struct LineaCurva: Shape {
     func path(in rect: CGRect) -> Path {
         var linea = Path()
         linea.move(to: CGPoint(x: rect.minX, y: rect.midY))
         linea.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.midX, y: 600))
             
             
         return linea
     }
 }
 */
