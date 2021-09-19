//
//  Add Quantity Buttons.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 6/8/21.
//

import SwiftUI


//
// MARK: Botones para Seleccionar la Cantidad de Bebida
//

struct AmountToAddAndQuantityButtons: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    var body: some View {
        
        VStack(spacing: 45) {
            HStack(spacing: 10) {
                Text("Amount Consumed:")
                Text("\(firebaseViewModel.drinkAmountToAdd) ml")
                    .padding(5)
                    .border(Color.white, width: 3)
            }
            
            HStack(spacing: 40) {
                
                ForEach(1..<6, id: \.self) { numeroBoton in
                    
                    Button(action: {
                        if numeroBoton == 1 {
                            // Añadir 10ml
                            firebaseViewModel.drinkAmountToAdd += 10
                            
                        } else if numeroBoton == 2 {
                            // Añadir 50ml
                            firebaseViewModel.drinkAmountToAdd += 50
                            
                        } else if numeroBoton == 3 {
                            // Añadir 100ml
                            firebaseViewModel.drinkAmountToAdd += 100
                            
                        } else if numeroBoton == 4 {
                            // Añadir 150ml
                            firebaseViewModel.drinkAmountToAdd += 150
                            
                        } else {
                            // Añadir 200ml (a lo mejor añadir 330 ml o a la cantidad de un vaso, lata, etc.)
                            firebaseViewModel.drinkAmountToAdd += 200
                        }
                        
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(maxWidth: 100, maxHeight: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(#colorLiteral(red: 0.9992401004, green: 0.6269122958, blue: 0, alpha: 1)), lineWidth: 6))
                            .foregroundColor(Color.white)
                    })
                }
            }
        }
    }
}
