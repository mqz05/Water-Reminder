//
//  Drinks Button (Model).swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 8/8/21.
//

import SwiftUI


//
// MARK: Botones Drinks
//

struct BotonDrink: View {
    
    var bebida: Bebida
    
    var body: some View {
        
            GeometryReader { geometry in
                
                let angulo = Double((geometry.frame(in: .global).minX - 350) / 6)
                
                Button(action: {
                    
                    
                }, label: {
                    VStack {
                        Text("\(bebida.nombreBebida)")
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(maxWidth: 100, maxHeight: 100)
                        .clipShape(Circle())
                        .overlay(Circle()
                                    .stroke(Color(#colorLiteral(red: 0.9992401004, green: 0.6269122958, blue: 0, alpha: 1)), lineWidth: 6))
                        .foregroundColor(Color.white)
                    }
                })
                    .padding(.leading, 25)
                    .rotation3DEffect(
                        Angle(degrees: angulo > 70 ? 70 : angulo < -70 ? -70 : angulo),
                        axis: (x: 0, y: 0.1, z: 0))
                    .scaleEffect(x: sacarEscalaBotones(geometria: geometry), y: sacarEscalaBotones(geometria: geometry))
                    .offset(x: CGFloat(sacarCoordsOffset(geometria: geometry)), y: 0)
                    .animation(.spring())
                
            }.frame(width: 150, height: 225, alignment: .center)
            .padding(.top, 50)
        }
}



// FUNCION: Sacar la escala de los botones

private func sacarEscalaBotones(geometria: GeometryProxy) -> CGFloat {
    var escala: CGFloat = 1
    
    let x = geometria.frame(in: .global).minX
    
    if x > 0 && x <= 417 {
        escala = 1 + (abs((x) / 200) * 0.45)
    } else if x > 417 && x < 834 {
        escala = 1 + (abs((x - 834) / 200) * 0.45)
    }
    
    return escala
}


// FUNCION: Sacar coordenadas del offset de los botones

private func sacarCoordsOffset(geometria: GeometryProxy) -> Double {
    let x = geometria.frame(in: .global).midX
    
    let left = x < 278 && x > 100
    let moreLeft = x <= 100
    
    let right = x > 556 && x < 734
    let moreRight = x >= 734
    
    let posicion = (x - 417)
    
    var numero = Double(posicion * 0.3)
    
    if left == true || right == true {
        numero = Double(posicion * 0.1)
    }else if moreLeft == true || moreRight == true {
        numero = Double(posicion * -0.05)
    }
    
    return numero
}
