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
