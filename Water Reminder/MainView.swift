//
//  MainView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 06/03/2021.
//

import SwiftUI


struct MainView: View {
    
    @State var isShowing = false
    
    @State var modo: MenuSectionsViewsModel = .dailyMode
    
    @State var home = HomeView(firstView: AnyView(DailyModeView()))
    
    var body: some View {
        
        NavigationView {
            ZStack {
                if isShowing == true {
                    MenuView(isShowing: $isShowing, home: $home)
                }
                
                home
                    .cornerRadius(isShowing ? 20 : 10)
                    .offset(x: isShowing ? 400 : 0, y:  isShowing ? 100 : 0)
                    .scaleEffect(x: isShowing ? 0.8 : 1, y: isShowing ? 0.8 : 1)
                    .shadow(color: Color.orange, radius: isShowing ? 10 : 0)
                    .navigationBarItems(leading: Button(action: {
                        withAnimation(.spring(), {
                            isShowing.toggle()
                        })
                    }, label: {
                        Image(systemName: "list.bullet.rectangle").resizable().frame(width: 40, height: 30).foregroundColor(.black)
                    }))
                    .ignoresSafeArea()
                    .allowsHitTesting(!isShowing)
                
                
                // Probar y ver si queda bien
                //.navigationTitle("Nombre del Modo")
                //.navigationBarTitleDisplayMode(.inline)
                
                if isShowing == true {
                    ReturnHomeLayer(isShowing: $isShowing)
                        .cornerRadius(20)
                        .offset(x: 399, y: 94)
                        .scaleEffect(x: 0.7, y: 0.83)
                        .opacity(0.1)
                }
            }
            
        }.navigationViewStyle(StackNavigationViewStyle())
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
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]), startPoint: .top, endPoint: .bottom)
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

struct ReturnHomeLayer: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        
        let layer = BackgroundView(topColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.01488226232)), bottomColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.01488226232)))
        
        Button(action: {
            withAnimation(.spring(), {
                isShowing.toggle()
            })
            
        }, label: {
            layer
        })
    }
}
