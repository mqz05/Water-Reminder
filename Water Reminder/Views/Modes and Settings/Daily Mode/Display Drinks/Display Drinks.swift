//
//  Display Drinks.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 8/8/21.
//

import SwiftUI


//
// MARK: Desplegar Botones Drinks
//

struct DisplayDrinks: View {
    
    @Binding var isSelectingDrink: Bool
    
    var body: some View {
        ZStack {
            if isSelectingDrink == true {
                
                FullScreenReturnHomeLayer(isSelectingDrink: $isSelectingDrink)
                    .opacity(0.25)
                
                
                //
                //Añadir fondo detras de los botones de las bebidas
                //
                
                
                ScrollViewDrinksButtons()
                    .offset(y: 250)
                    .scaleEffect(x: 0.8, y: 0.8)
            }
        }
    }
}
