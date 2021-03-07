//
//  MenuView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 06/03/2021.
//

import SwiftUI

struct MenuView: View {
    
    @Binding var isShowing: Bool
    @Binding var home: HomeView
    
    var body: some View {
        
        ZStack {
            BackgroundView(topColor: Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)), bottomColor: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
            
            VStack(alignment: .leading, spacing: 10) {
                MenuTitle(isShowing: $isShowing)
                
                WiderDivisorHorizontal(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), height: 300,  opacity: 0.5).offset(x: -25)
                
                MenuModes(home: $home, isShowing: $isShowing)
                
                Spacer()
                
                WiderDivisorHorizontal(color: Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)), height: 300, opacity: 0.5).offset(x: -25)
                
                Settings()
                
            }.padding(.leading, 25).padding(.top, 5).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading).shadow(color: Color.orange, radius: 0)
            
            
        }.navigationBarHidden(true)
    }
    // CHECKEAR .onAppear y .hidden (para mostrar y esconder la lista de modos, titulo de "Menu", settings, etc.
    
}

/*
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(isShowing: .constant(true), home: .constant(HomeView(firstView: DailyModeView())).previewLayout (.device)
    }
}*/

struct MenuTitle: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        HStack {
            
            Button(action: {
                withAnimation(.spring(), {
                    isShowing.toggle()
                })
                
            }, label: {
                Image(systemName: "list.bullet.rectangle")
                    .resizable()
                    .frame(width: 40, height: 30)
                    .padding(.trailing, 15)
                    .foregroundColor(.black)
                    .offset(x: -5)
            })
            
            Text("Menu")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.black)
                .padding(.leading, 15).padding(.trailing, 30)
        }
    }
}

struct MenuModes: View {
    
    @Binding var home: HomeView
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(spacing: 50) {
            ForEach(MenuSectionsViewsModel.allCases, id: \.self) { seccion in
                Button(
                    action: {
                        home = HomeView(firstView: findSelectedView(sectionName: seccion.sectionName))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {withAnimation(.spring(), {
                            isShowing.toggle()
                            // Tal vez poner animacion de cargando
                        })})
                        
                    },
                    label: {
                        SectionView(section: seccion).border(Color.black, width: 2)
                    })
            }
        }
        .padding(.top, 20)
    }
}


func findSelectedView(sectionName: String) -> AnyView {
    if sectionName == "Daily Mode" {
        return AnyView(DailyModeView())
        
    } else if sectionName == "Free Mode" {
        return AnyView(FreeModeView())
        
    } else if sectionName == "Drink & Rest" {
        return AnyView(Drink_RestView())
        
    } else if sectionName == "Statistics" {
        return AnyView(StatisticsView())
        
    } else {
        return AnyView(DailyModeView())
    }
}

struct Settings: View {
    var body: some View {
        NavigationLink(destination: SettingsView(), label: {
            HStack(spacing: 2.5) {
                Image("Settings Icon").resizable().frame(width: 55, height: 55)
                
                Text("Settings")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
            }
        })
    }
}
