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
    
    @State var home: HomeView = HomeView(firstView: AnyView(Color.white))
    
    var body: some View {
        
        NavigationView {
            ZStack {
                if isShowingMenu == true {
                    MenuView(isShowingMenu: $isShowingMenu, home: $home)
                }
                
                SetUpHomeView(home: $home, isShowingMenu: $isShowingMenu)
                
                if isShowingMenu == true {
                    MiniReturnHomeLayer(isShowingMenu: $isShowingMenu)
                        .frame(width: 834, height: 1194)
                        .cornerRadius(isShowingMenu ? 20 : 10)
                        .offset(x: isShowingMenu ? 400 : 0, y: isShowingMenu ? 25 : 0)
                        .scaleEffect(x: isShowingMenu ? 0.82 : 1, y: isShowingMenu ? 0.82 : 1)
                        
                        .opacity(0.1)
                }
            }.onAppear {
                home = HomeView(firstView: AnyView(DailyModeView(isShowingMenu: $isShowingMenu)))
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
                .frame(width: 834, height: 1194)
                .cornerRadius(isShowingMenu ? 20 : 10)
                .offset(x: isShowingMenu ? 275 : 0, y:  isShowingMenu ? 30 : 0)
                .scaleEffect(x: isShowingMenu ? 0.48 : 1, y: isShowingMenu ? 0.7 : 1)
                .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
            
            Color.white
                .opacity(0.5)
                .frame(width: 834, height: 1194)
                .cornerRadius(isShowingMenu ? 20 : 10)
                .offset(x: isShowingMenu ? 350 : 0, y:  isShowingMenu ? 30 : 0)
                .scaleEffect(x: isShowingMenu ? 0.65 : 1, y: isShowingMenu ? 0.75 : 1)
                .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
            
            home
                .frame(width: 834, height: 1194)
                .cornerRadius(isShowingMenu ? 20 : 10)
                .offset(x: isShowingMenu ? 400 : 0, y: isShowingMenu ? 90 : 0)
                .scaleEffect(x: isShowingMenu ? 0.82 : 1, y: isShowingMenu ? 0.82 : 1)
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
