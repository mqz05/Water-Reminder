//
//  MenuView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 06/03/2021.
//

import SwiftUI


//
// MARK: Menu Principal
//

struct MenuView: View {
    
    @Binding var isShowingMenu: Bool
    @Binding var home: HomeView
    @State var showLogOutNotification = false
    
    var body: some View {
        
        ZStack {
            BackgroundView(topColor: Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)), bottomColor: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), isHorizontal: true)
            
            
            VStack(alignment: .leading, spacing: 25) {
                
                Profile()
                
                MenuModes(home: $home, isShowingMenu: $isShowingMenu, modoSeleccionado: modoSeleccionadoActual)
                    .scaleEffect(1.3)
                    .padding(.top, 30)
                    .padding(.leading, 10)
                
                Spacer()
                
                ManageAccount(showLogOutNotification: $showLogOutNotification)
                    .padding(.bottom, 30)
                
            }
            .padding(.leading, 25)
            .frame(maxWidth: .infinity, maxHeight: 1100, alignment: .leading)
            .alert(isPresented: $showLogOutNotification, content: {
                return Alert(title: Text("Succesfully logged out"), dismissButton: .cancel(Text("Return")))
            })
            
            
        }.navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {withAnimation(.spring(), { isShowingMenu.toggle() })}, label: {
            BotonCruz()
                .frame(width: 40, height: 30)
                .padding(.trailing, 15)
                .foregroundColor(.black)
                .offset(x: -5)
        }))
    }
}
