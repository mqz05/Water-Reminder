//
//  DailyModeView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 07/03/2021.
//

import SwiftUI

struct DailyModeView: View {
    
    @State var addWaterAmount: Int = 0
    
    @State var totalWaterAmount: Int = 0
    
    @State var waterObjective: Int = 2000
    
    @State var porcentaje: CGFloat = 0
    
    var body: some View {
        ZStack {
            BackgroundView(topColor: Color(#colorLiteral(red: 0.4080183647, green: 0.6348306513, blue: 1, alpha: 1)), bottomColor: Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)))
            
            VStack(spacing: 5) {
                TitleAndImage()
                
                DrinksButton()
                
                AddQuantityButtons(waterAmount: $addWaterAmount)
                
                TotalAmountView(waterAmount: $addWaterAmount)
                
                AddAndResetButtons(addWaterAmount: $addWaterAmount, totalWaterAmount: $totalWaterAmount, waterObjective: $waterObjective, porcentaje: $porcentaje)
            }
            
            BarraDeProgreso(porcentaje: $porcentaje)
        }
    }
}

struct DailyModeView_Previews: PreviewProvider {
    static var previews: some View {
        DailyModeView()
    }
}

struct TitleAndImage: View {
    var body: some View {
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
        }
    }
}

struct DrinksButton: View {
    var body: some View {
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
    }
}

struct AddQuantityButtons: View {
    
    @Binding var waterAmount: Int
    
    var body: some View {
        HStack(spacing: 40) {
            
            ForEach(1..<6, id: \.self) { numeroBoton in
                
                Button(action: {
                    if numeroBoton == 1 {
                        // Añadir 10ml
                        waterAmount = waterAmount + 10
                        
                    } else if numeroBoton == 2 {
                        // Añadir 50ml
                        waterAmount = waterAmount + 50
                        
                    } else if numeroBoton == 3 {
                        // Añadir 100ml
                        waterAmount = waterAmount + 100
                        
                    } else if numeroBoton == 4 {
                        // Añadir 150ml
                        waterAmount = waterAmount + 150
                        
                    } else {
                        // Añadir 200ml
                        waterAmount = waterAmount + 200
                        
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
    }
}

struct TotalAmountView: View {
    
    @Binding var waterAmount: Int
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Total Amount:")
            Text("\(waterAmount) ml")
                .padding(5)
                .border(Color.white, width: 3)
        }
        .padding(.bottom, 25)
    }
}

struct AddAndResetButtons: View {
    
    @Binding var addWaterAmount: Int
    
    @Binding var totalWaterAmount: Int
    
    @Binding var waterObjective: Int
    
    @Binding var porcentaje: CGFloat
    
    var body: some View {
        HStack {
            Button(action: {
                // Añadir Cantidad (Boton Add)
                totalWaterAmount = totalWaterAmount + addWaterAmount
                addWaterAmount = 0
                porcentaje = calcularPorcentaje() / 100
                
            }, label: {
                Image(systemName: "plus.rectangle.fill")
                    .resizable()
                    .frame(maxWidth: 125, maxHeight: 100)
                    .foregroundColor(Color.white)
                    .cornerRadius(25)
            })
            .padding(.leading, 250)
            
            Button(action: {
                // Restablecer Cantidad (Boton Reset)
                addWaterAmount = 0
                
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
    
    func calcularPorcentaje() -> CGFloat {
        
        let nuevoPorcentaje = totalWaterAmount * 100 / waterObjective
        
        return CGFloat(nuevoPorcentaje)
    }
}

struct BarraDeProgreso: View {
    
    @Binding var porcentaje: CGFloat
    
    var body: some View {
        
        ZStack() {
            
            Capsule().fill(Color.black.opacity(0.8))
                .frame(width: 52, height: 702)
            
            ZStack(alignment: .bottom) {
                Capsule().fill(Color(#colorLiteral(red: 0.755085593, green: 0.7882685688, blue: 0.8353505505, alpha: 1)))
                    .frame(width: 50, height: 700)
                
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .bottom, endPoint: .top))
                    .frame(width: 50, height: cambiarBarraPorcentaje())
                
            }
            Text(String(format: "%.0f", self.porcentaje * 100) + "%")
                .offset(y: -320)
            
        }.offset(x: 355, y: -190)
    }
    
    func cambiarBarraPorcentaje() -> CGFloat {
        let altura = 700
        var nuevoTamaño = CGFloat(altura) * self.porcentaje
        
        if nuevoTamaño > 700 {
            nuevoTamaño = 700
        }
        
        return nuevoTamaño
    }
}
