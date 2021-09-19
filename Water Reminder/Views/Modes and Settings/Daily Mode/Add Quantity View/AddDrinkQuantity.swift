//
//  AddDrinkAmountView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 19/8/21.
//

import SwiftUI

struct AddDrinkQuantity: View {
    
    @Binding var estadoActual: DailyModePhases
    
    var body: some View {
        VStack(spacing: 45) {
            AmountToAddAndQuantityButtons()
            
            AddAndResetButtons(estadoActual: $estadoActual)
        }
    }
}
