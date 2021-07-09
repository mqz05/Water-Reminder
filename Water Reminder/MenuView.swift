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
            BackgroundView(topColor: Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)), bottomColor: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), isHorizontal: true)
            
            
            VStack(alignment: .leading, spacing: 10) {
                MenuTitle(isShowing: $isShowing)
                
                Profile()
                
                MenuModes(home: $home, isShowing: $isShowing, modoSeleccionado: modoSeleccionadoActual).scaleEffect(1.3).padding(.top, 30)
                
                Spacer()
                
                ManageAccount()
                
            }.padding(.leading, 25).padding(.top, 5).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            
        }.navigationBarHidden(true)
    }
}

/*
 struct MenuView_Previews: PreviewProvider {
 static var previews: some View {
 MenuView(isShowing: .constant(true), home: .constant(HomeView(firstView: DailyModeView())).previewLayout (.device)
 }
 }*/



//
// MARK: Titulo del Menu
//

struct MenuTitle: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        HStack {
            
            Button(action: {
                withAnimation(.spring(), {
                    isShowing.toggle()
                })
                
            }, label: {
                BotonCruz()
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



//
// MARK: Profile
//

struct Profile: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Image("Imagen Prueba")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .cornerRadius(10)
                .padding(.top, 50)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text("Nickname")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    Image("Imagen Prueba"/* Emblem */)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .cornerRadius(5)
                    
                    Text("Badge")
                        .fontWeight(.semibold)
                        .opacity(0.7)
                        .foregroundColor(.white)
                }
            }.scaleEffect(1.2)
            .padding(.leading, 10)
            .padding(.top, 6)
        }
    }
}



//
// MARK: Modos del Menu
//

struct MenuModes: View {
    
    @Binding var home: HomeView
    @Binding var isShowing: Bool
    @State var modoSeleccionado: String
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(MenuSectionsViewsModel.allCases, id: \.self) { seccion in
                Button(
                    action: {
                        /*
                        home = HomeView(firstView: findSelectedView(sectionName: seccion.sectionName))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {withAnimation(.spring(), {
                            isShowing.toggle()
                            // Tal vez poner animacion de cargando
                        })})*/
                        withAnimation(.spring()) {modoSeleccionado = seccion.sectionName}
                        home = HomeView(firstView: findSelectedView(sectionName: seccion.sectionName))
                },
                    label: {
                        SectionView(section: seccion, modoSeleccionado: $modoSeleccionado)
                            
                    }).foregroundColor(modoSeleccionado == seccion.sectionName ? .blue : .white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .background(
                        ZStack{
                            if modoSeleccionado == seccion.sectionName {
                                Color.white
                                    .opacity(modoSeleccionado == seccion.sectionName ? 1 : 0)
                                    .clipShape(EsquinasRedondeadas(esquinas: [.topRight, .bottomRight], radio: 12))
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
            }
        }
        .padding(.top, 50)
        .padding(.leading, -10)
    }
}


// FUNCION: cambio a la vista seleccionada

func findSelectedView(sectionName: String) -> AnyView {
    if sectionName == "Daily Mode" {
        modoSeleccionadoActual = "Daily Mode"
        return AnyView(DailyModeView())
        
    } else if sectionName == "Free Mode" {
        modoSeleccionadoActual = "Free Mode"
        return AnyView(FreeModeView())
        
    } else if sectionName == "Drink & Rest" {
        modoSeleccionadoActual = "Drink & Rest"
        return AnyView(Drink_RestView())
        
    } else if sectionName == "Statistics" {
        modoSeleccionadoActual = "Statistics"
        return AnyView(StatisticsView())
        
    } else if sectionName == "Settings" {
        modoSeleccionadoActual = "Settings"
        return AnyView(SettingsView())
        
    } else {
        modoSeleccionadoActual = "Daily Mode"
        return AnyView(DailyModeView())
    }
}



//
// MARK: Configuracion
//

struct ManageAccount: View {
    var body: some View {
        NavigationLink(destination: SettingsView(), label: {
            HStack(spacing: 15) {
                Image(systemName: "rectangle.righthalf.inset.fill.arrow.right").resizable().frame(width: 35, height: 26.25).foregroundColor(.white)
                
                Text("Log in / Log out"/* cambiar dependiendo si hay una cuenta o no */)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        })
    }
}
