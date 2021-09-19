//
//  MenuModes.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 9/8/21.
//

import SwiftUI


//
// MARK: Modos del Menu
//

struct MenuModes: View {
    
    @Binding var home: HomeView
    @Binding var isShowingMenu: Bool
    @State var modoSeleccionado: String
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(MenuModesData.allCases, id: \.self) { seccion in
                Button(
                    action: {
                        withAnimation(.spring()) {modoSeleccionado = seccion.sectionName}
                        home = HomeView(firstView: findSelectedView(sectionName: seccion.sectionName, isShowingMenu: $isShowingMenu))
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


// FUNCION: Cambio a la vista seleccionada

func findSelectedView(sectionName: String, isShowingMenu: Binding<Bool>) -> AnyView {
    if sectionName == "Daily Mode" {
        modoSeleccionadoActual = "Daily Mode"
        return AnyView(DailyModeView(isShowingMenu: isShowingMenu))
        
    } else if sectionName == "Water Calculator" {
        modoSeleccionadoActual = "Water Calculator"
        return AnyView(WaterCalculatorView())//AnyView(WaterCalculatorView())
        
    } else if sectionName == "Drink & Rest" {
        modoSeleccionadoActual = "Drink & Rest"
        return AnyView(DrinkAndRestView())
        
    } else if sectionName == "Statistics" {
        modoSeleccionadoActual = "Statistics"
        return AnyView(StatisticsView())
        
    } else if sectionName == "Settings" {
        modoSeleccionadoActual = "Settings"
        return AnyView(SettingsView())
        
    } else {
        modoSeleccionadoActual = "Daily Mode"
        return AnyView(DailyModeView(isShowingMenu: isShowingMenu))
    }
}
