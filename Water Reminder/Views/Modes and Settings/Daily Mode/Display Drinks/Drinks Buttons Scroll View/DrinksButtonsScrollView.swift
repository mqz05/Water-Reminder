//
//  Drinks Buttons Scroll View.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 8/8/21.
//

import SwiftUI


//
// MARK: Scroll View Botones Bebidas
//

struct ScrollViewDrinksButtons: View {
    
    @ObservedObject var tiposDeBebidas = TiposDeBebidaTotales()
    
    init() {
        tiposDeBebidas.añadirBebidas(at: 0)
    }
    
    var body: some View {
        
        ZStack {
            ScrollViewReader { scrollView in
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHStack(spacing: 30) {
                        
                        ForEach(tiposDeBebidas.bebida.indices, id: \.self) { indiceBebida in
                            
                            let bebida = tiposDeBebidas.bebida[indiceBebida]
                            
                            BotonDrink(bebida: bebida).onAppear {
                                
                                if bebida.id == -2 {
                                    withAnimation(.spring(), {
                                        scrollView.scrollTo(11, anchor: .center)
                                    })
                                } else if bebida.id == 12 {
                                    withAnimation(.spring(), {
                                        scrollView.scrollTo(3, anchor: .center)
                                    })
                                }
                            }
                        }
                    }.onAppear {
                        withAnimation(.spring(), {
                            scrollView.scrollTo(3, anchor: .center)
                        })
                    }
                }.frame(width: 680, height: 275)
            }
        }
    }
}
