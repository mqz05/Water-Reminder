//
//  MainView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 06/03/2021.
//

import SwiftUI


// Modo Seleccionado Actual
var modoSeleccionadoActual = "Daily Mode"


//
// MARK: View Principal
//

struct MainView: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @State var isShowingMenu = false
    
    @State var modo: MenuModesData = .dailyMode
    
    @State var home = HomeView(firstView: AnyView(DailyModeView()))
    
    var body: some View {
        
        NavigationView {
            ZStack {
                if isShowingMenu == true {
                    MenuView(isShowingMenu: $isShowingMenu, home: $home)
                }
                
                SetUpHomeView(home: $home, isShowingMenu: $isShowingMenu)
                
                if isShowingMenu == true {
                    MiniReturnHomeLayer(isShowingMenu: $isShowingMenu)
                        .cornerRadius(20)
                        .offset(x: 399, y: 94)
                        .scaleEffect(x: 0.7, y: 0.83)
                        .opacity(0.1)
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


//
// MARK: View En Pantalla
//

struct HomeView: View {
    
    var firstView: AnyView
    
    var body: some View {
        ZStack {
            firstView
        }
    }
}


//
// MARK: Ajustar View Principal (en el menu)
//

struct SetUpHomeView: View {
    
    @Binding var home: HomeView
    
    @Binding var isShowingMenu: Bool
    
    var body: some View {
        
        ZStack {
            Color.white
                .opacity(0.4)
                .cornerRadius(isShowingMenu ? 20 : 10)
                .offset(x: isShowingMenu ? 275 : 0, y:  isShowingMenu ? 30 : 0)
                .scaleEffect(x: isShowingMenu ? 0.48 : 1, y: isShowingMenu ? 0.775 : 1)
                .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
            
            Color.white
                .opacity(0.5)
                .cornerRadius(isShowingMenu ? 20 : 10)
                .offset(x: isShowingMenu ? 350 : 0, y:  isShowingMenu ? 30 : 0)
                .scaleEffect(x: isShowingMenu ? 0.65 : 1, y: isShowingMenu ? 0.825: 1)
                .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
            
            home
                .cornerRadius(isShowingMenu ? 20 : 10)
                .offset(x: isShowingMenu ? 400 : 0, y:  isShowingMenu ? 100 : 0)
                .scaleEffect(x: isShowingMenu ? 0.8 : 1, y: isShowingMenu ? 0.8 : 1)
                .shadow(color: Color.white, radius: isShowingMenu ? 7.5 : 0)
                .navigationBarItems(leading: Button(action: {
                    withAnimation(.spring(), {
                        isShowingMenu.toggle()
                    })
                }, label: {
                    BotonTresLineas()
                        .frame(width: 40, height: 30)
                        .foregroundColor(.black)
                        .scaleEffect(1.2)
                }))
                .ignoresSafeArea()
                .allowsHitTesting(!isShowingMenu)
        }
    }
}
