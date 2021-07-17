//
//  MainView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 06/03/2021.
//

import SwiftUI

var modoSeleccionadoActual = "Daily Mode"

struct MainView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var isShowing = false
    
    @State var modo: MenuSectionsViewsModel = .dailyMode
    
    @State var home = HomeView(firstView: AnyView(DailyModeView()))
    
    var body: some View {
        
        NavigationView {
            ZStack {
                if isShowing == true {
                    MenuView(isShowing: $isShowing, home: $home)
                }
                
                SetUpHomeView(home: $home, isShowing: $isShowing)
                
                if isShowing == true {
                    MiniReturnHomeLayer(isShowing: $isShowing)
                        .cornerRadius(20)
                        .offset(x: 399, y: 94)
                        .scaleEffect(x: 0.7, y: 0.83)
                        .opacity(0.1)
                }
            }
            
        }.navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.loggedIn = viewModel.isLogedIn
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


//
// MARK: Vista de Fondo Degradado
//

struct BackgroundView: View {
    var topColor: Color
    var bottomColor: Color
    var isHorizontal: Bool
    
    var body: some View {
        
        isHorizontal ? LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]), startPoint: .leading, endPoint: .trailing)
            .ignoresSafeArea(edges: .all) : LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(edges: .all)
    }
}

struct HomeView: View {
    
    var firstView: AnyView
    
    var body: some View {
        ZStack {
            
            firstView
        }
    }
}



//
// MARK: Mini Return Home Layer
//

struct MiniReturnHomeLayer: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        
        let layer = BackgroundView(topColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.01488226232)), bottomColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.01488226232)), isHorizontal: false)
        
        Button(action: {
            withAnimation(.spring(), {
                isShowing.toggle()
            })
            
        }, label: {
            layer
        })
    }
}


struct SetUpHomeView: View {
    
    @Binding var home: HomeView
    
    @Binding var isShowing: Bool
    
    var body: some View {
        
        ZStack {
            Color.white
                .opacity(0.4)
                .cornerRadius(isShowing ? 20 : 10)
                .offset(x: isShowing ? 275 : 0, y:  isShowing ? 100 : 0)
                .scaleEffect(x: isShowing ? 0.48 : 1, y: isShowing ? 0.7 : 1)
                .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
            
            Color.white
                .opacity(0.5)
                .cornerRadius(isShowing ? 20 : 10)
                .offset(x: isShowing ? 350 : 0, y:  isShowing ? 100 : 0)
                .scaleEffect(x: isShowing ? 0.65 : 1, y: isShowing ? 0.75 : 1)
                .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
            
            home
                .cornerRadius(isShowing ? 20 : 10)
                .offset(x: isShowing ? 400 : 0, y:  isShowing ? 100 : 0)
                .scaleEffect(x: isShowing ? 0.8 : 1, y: isShowing ? 0.8 : 1)
                .shadow(color: Color.white, radius: isShowing ? 7.5 : 0)
                .navigationBarItems(leading: Button(action: {
                    withAnimation(.spring(), {
                        isShowing.toggle()
                    })
                }, label: {
                    BotonTresLineas()
                        .frame(width: 40, height: 30)
                        .foregroundColor(.black)
                        .scaleEffect(1.2)
                }))
                .ignoresSafeArea()
                .allowsHitTesting(!isShowing)
        }
    }
}
