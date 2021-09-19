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
        VStack {
            Text("\(bebida.nombreBebida)")
            
            
            Image("\(bebida.nombreImagen)")
                .resizable()
                .frame(maxWidth: 85, maxHeight: 85)
                .clipShape(Circle().scale(1.2))
                .overlay(Circle().scale(1.2).stroke(Color(#colorLiteral(red: 0.9992401004, green: 0.6269122958, blue: 0, alpha: 1)), lineWidth: 5))
                
            
        }
    }
}
