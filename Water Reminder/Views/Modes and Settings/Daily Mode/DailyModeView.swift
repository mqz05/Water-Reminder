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
    
    @State var estadoActual: DailyModePhases = .home
    
    @Binding var isShowingMenu: Bool
    
    var body: some View {
        ZStack {
            
            BackgroundView(topColor: Color(#colorLiteral(red: 0.4080183647, green: 0.6348306513, blue: 1, alpha: 1)), bottomColor: Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)), isHorizontal: false)
            
            WaveBackground(graphWidth: 0.3, amplitude: 0.01).fill(Color(#colorLiteral(red: 0.434438613, green: 0.5581636017, blue: 1, alpha: 1))).offset(y: 220)
            
            VStack(spacing: 25) {
                
                DailyModeTitle()
                
                ProgressBar()
                
                ZStack {
                    
                    if estadoActual != .home {
                        Button(action: {
                            withAnimation(Animation.spring(), {
                                estadoActual = .home
                            })
                        }, label: {
                            Image(systemName: "chevron.backward.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        })
                        .offset(x: -355, y: 140)
                    }
                    
                    if estadoActual == .home {
                        SelectDrinksButton(estadoActual: $estadoActual)
                            .offset(y: 10)
                        
                    } else if estadoActual == .selectDrink {
                        DrinksCarousel(estadoActual: $estadoActual)
                        
                    } else if estadoActual == .selectQuantity {
                        AddDrinkQuantity(estadoActual: $estadoActual)
                    }
                }
                .frame(width: 834, height: 375)
            }
        }
    }
}
