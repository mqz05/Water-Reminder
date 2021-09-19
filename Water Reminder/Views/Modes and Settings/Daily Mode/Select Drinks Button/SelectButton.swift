//
//  DisplayDrinksButton.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 6/8/21.
//

import SwiftUI


//
// MARK: Boton Bebidas
//

struct SelectDrinksButton: View {
    
    @Binding var estadoActual: DailyModePhases
    
    var body: some View {
        Button(action: {
            withAnimation(Animation.spring(), {
                estadoActual = .selectDrink
            })
            
        }, label: {
            Text("Drink!")
                .font(.custom("NewAcademy", size: 32))
                .foregroundColor(Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)))
                .frame(width: 225, height: 70)
                .background(
                    Color.white
                        .clipShape(EsquinasRedondeadas(esquinas: .allCorners, radio: 25))
                )
        })
    }
}
