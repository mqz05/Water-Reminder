//
//  DailyModeView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 07/03/2021.
//

import SwiftUI

struct DailyModeView: View {
    var body: some View {
        ZStack {
            BackgroundView(topColor: Color(#colorLiteral(red: 0.4080183647, green: 0.6348306513, blue: 1, alpha: 1)), bottomColor: Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)))
            
            VStack(spacing: 5) {
                Text("Daily Mode")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.purple)
                    .padding(.top, 15)
                
                Image("Imagen Prueba")
                    .resizable()
                    .frame(maxWidth: 500, maxHeight: 500)
                    .clipShape(Circle())
                    .overlay(Circle()
                                .stroke(Color.orange, lineWidth: 6))
                    .shadow(color: Color.yellow, radius: 20)
                    .padding(.vertical, 35.0)
                    .padding(.bottom, 15)
                
                VStack(spacing: 5) {
                    Text("Drinks")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(Color.green)
                    
                    Button(action: {
                        // Desplegar todas las bebidas (Selector de Bebida)
                        
                    }, label: {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(maxWidth: 100, maxHeight: 100)
                            .clipShape(Circle())
                            .overlay(Circle()
                                        .stroke(Color.green, lineWidth: 6))
                            .foregroundColor(Color.white)
                    })
                }
                .padding(.bottom, 30.0)
                
                HStack(spacing: 40) {
                    
                    ForEach(1..<6, id: \.self) { numeroBoton in
                        
                        Button(action: {
                            if numeroBoton == 1 {
                                // Añadir 10ml
                                
                            } else if numeroBoton == 2 {
                                // Añadir 50ml
                                
                            } else if numeroBoton == 3 {
                                // Añadir 100ml
                                
                            } else if numeroBoton == 4 {
                                // Añadir 150ml
                                
                            } else {
                                // Añadir 200ml
                                
                            }
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(maxWidth: 100, maxHeight: 100)
                                .clipShape(Circle())
                                .overlay(Circle()
                                            .stroke(Color.green, lineWidth: 6))
                                .foregroundColor(Color.white)
                        })
                    }
                }
                .padding(.bottom, 30.0)
                
                VStack(spacing: 5) {
                    Text("Total Amount:")
                    Text("Añadir Variable que suma la cantidad")
                        .padding(5)
                        .border(Color.white, width: 3)
                }
                .padding(.bottom, 25)
                
                HStack {
                    Button(action: {
                        // Añadir Cantidad (Boton Add)
                        
                    }, label: {
                        Image(systemName: "plus.rectangle.fill")
                            .resizable()
                            .frame(maxWidth: 125, maxHeight: 100)
                            .foregroundColor(Color.white)
                            .cornerRadius(25)
                    })
                    .padding(.leading, 250)
                    
                    Button(action: {
                        // Restablecer Cantidd (Boton Reset)
                        
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .frame(maxWidth: 100, maxHeight: 75)
                            .foregroundColor(Color.white)
                    })
                    .padding(.leading, 150)
                }
                .padding(.bottom, 5.0)
            }
        }
    }
}

struct DailyModeView_Previews: PreviewProvider {
    static var previews: some View {
        DailyModeView()
    }
}
