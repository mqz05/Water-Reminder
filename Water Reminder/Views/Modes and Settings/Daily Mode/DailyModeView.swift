//
//  DailyModeView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 07/03/2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore


//
// MARK: Daily Mode View
//

struct DailyModeView: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @State var isSelectingDrink: Bool = false
    
    var body: some View {
        ZStack {
            
            BackgroundView(topColor: Color(#colorLiteral(red: 0.4080183647, green: 0.6348306513, blue: 1, alpha: 1)), bottomColor: Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)), isHorizontal: false)
            
            VStack(spacing: 5) {
                
                Text("Daily Mode")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color(#colorLiteral(red: 0.7302836776, green: 0.401488483, blue: 0.9478703141, alpha: 1)))
                    .padding(.top, 15)
                
                ProgressBar()
                
                SelectDrinksButton(isSelectingDrink: $isSelectingDrink)
                    .allowsHitTesting(!isSelectingDrink)
                
                AddQuantityButtons()
                    .allowsHitTesting(!isSelectingDrink)
                
                DailyWaterAmount()
                
                AddAndResetButtons()
                    .allowsHitTesting(!isSelectingDrink)
            }
            
            //BarraDeProgreso()
            
            DisplayDrinks(isSelectingDrink: $isSelectingDrink)
        }
    }
}



/*
//
// MARK: Barra de Progreso
//

struct BarraDeProgreso: View {
    
    @EnvironmentObject var dailyModeViewModel: DailyModeViewModel
    
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
            Text(String(format: "%.0f", dailyModeViewModel.calcularPorcentaje()) + "%")
                .offset(y: -320)
            
        }.offset(x: 355, y: -190)
    }
    
    // FUNCION: Calcular el cambio de la barra de progreso
    func cambiarBarraPorcentaje() -> CGFloat {
        let altura = 700
        var nuevoTamaño = CGFloat(altura) * (dailyModeViewModel.calcularPorcentaje() / 100)
        
        if nuevoTamaño > 700 {
            nuevoTamaño = 700
        }
        
        return nuevoTamaño
    }
}

*/
