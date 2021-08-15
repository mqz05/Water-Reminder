//
//  Daily Water Amount.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 6/8/21.
//

import SwiftUI


//
// MARK: Vista de la Cantidad de Bebida Seleccionada
//

struct DailyWaterAmount: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Total Amount:")
            Text("\(firebaseViewModel.waterAmountToAdd) ml")
                .padding(5)
                .border(Color.white, width: 3)
        }
        .padding(.bottom, 25)
    }
}
