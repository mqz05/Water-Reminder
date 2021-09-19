//
//  Add Water Button.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 6/8/21.
//

import SwiftUI


//
// MARK: Boton Añadir Cantidad de Bebida al Total
//

struct AddAndResetButtons: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @EnvironmentObject var waveViewModel: WaveViewModel
    
    @State private var showConfirmation: Bool = false
    
    @Binding var estadoActual: DailyModePhases
    
    var body: some View {
        HStack {
            Button(action: {
                // Añadir Cantidad (Boton Add)
                self.showConfirmation = true
                
            }, label: {
                Text("Add")
                    .font(.custom("NewAcademy", size: 25))
                    .foregroundColor(Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)))
                    .frame(width: 185, height: 55)
                    .background(
                        Color.white
                            .clipShape(EsquinasRedondeadas(esquinas: [.topLeft, .bottomLeft], radio: 18))
                    )
            })
                
            
            Button(action: {
                // Restablecer Cantidad (Boton Reset)
                firebaseViewModel.drinkAmountToAdd = 0
                
            }, label: {
                Text("Reset")
                    .font(.custom("NewAcademy", size: 25))
                    .foregroundColor(Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)))
                    .frame(width: 185, height: 55)
                    .background(
                        Color.white
                            .clipShape(EsquinasRedondeadas(esquinas: [.topRight, .bottomRight], radio: 18))
                    )
            })
        }
        
        // Alerta de confirmacion para añadir cantidad de bebida al total
        .alert(isPresented: $showConfirmation, content: {
            if firebaseViewModel.drinkAmountToAdd > 0 {
                return Alert(
                    title: Text("Do you want to add this amount?"),
                    message: Text("Check the quantity"),
                    primaryButton: .default(Text("Add")) {
                        
                        withAnimation(Animation.spring(), {
                            estadoActual = .home
                        })
                        
                        firebaseViewModel.addWaterAmountToTotal()
                        
                        firebaseViewModel.updateUserData()
                        
                        waveViewModel.updateWaveMotion()
                    },
                    secondaryButton: .cancel()
                )
            } else {
                return Alert(title: Text("Select a amount to add"), dismissButton: .cancel(Text("Return")))
            }
        })
    }
}
