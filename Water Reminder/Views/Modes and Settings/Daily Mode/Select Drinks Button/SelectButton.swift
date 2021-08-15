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
    
    @Binding var isSelectingDrink: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Drinks")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color(#colorLiteral(red: 0.9992401004, green: 0.6269122958, blue: 0, alpha: 1)))
            
            Button(action: {
                // Desplegar todas las bebidas (Selector de Bebida)
                isSelectingDrink = true
                
            }, label: {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color(#colorLiteral(red: 0.9992401004, green: 0.6269122958, blue: 0, alpha: 1)), lineWidth: 6))
                    .foregroundColor(Color.white)
            })
        }
        .padding(.bottom, 30.0)
    }
}
