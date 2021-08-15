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
    
    var body: some View {
        HStack {
            Button(action: {
                // Añadir Cantidad (Boton Add)
                self.showConfirmation = true
                
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
                firebaseViewModel.waterAmountToAdd = 0
                
            }, label: {
                Image(systemName: "minus.circle.fill")
                    .resizable()
                    .frame(maxWidth: 100, maxHeight: 75)
                    .foregroundColor(Color.white)
            })
                .padding(.leading, 150)
        }
        .padding(.bottom, 5.0)
        
        // Alerta de confirmacion para añadir cantidad de bebida al total
        .alert(isPresented: $showConfirmation, content: {
            if firebaseViewModel.waterAmountToAdd > 0 {
                return Alert(
                    title: Text("Do you want to add this amount?"),
                    message: Text("Check the quantity"),
                    primaryButton: .default(Text("Add")) {
                        
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
