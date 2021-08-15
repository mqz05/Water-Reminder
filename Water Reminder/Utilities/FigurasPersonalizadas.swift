//
//  FigurasPersonalizadas.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 01/07/2021.
//

import SwiftUI


//
// MARK: Seccion del Formulario de Datos
//

struct SeccionDatos: View {
    
    var titulo: String!
    @Binding var contenido: String
    var isPassword: Bool!
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text(titulo)
                .font(.custom("NewAcademy", size: 24))
            
            if isPassword {
                SecureField("Type here...", text: $contenido)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(width: 750, height: 20)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
            } else {
                TextField("Type here...", text: $contenido)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(width: 750, height: 20)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
            }
        }
    }
}



//
// MARK: Redondear Esquinas
//

struct EsquinasRedondeadas: Shape {
    
    var esquinas: UIRectCorner
    var radio: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: esquinas, cornerRadii: CGSize(width: radio, height: radio))
        
        return Path(path.cgPath)
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



//
// MARK: Boton Tres Lineas (Menu)
//

struct BotonTresLineas: View {
    
    var body: some View {
        
        VStack(spacing: 5) {
            Capsule()
                .fill(Color.white)
                .frame(width: 30, height: 3)
            Capsule()
                .fill(Color.white)
                .frame(width: 30, height: 3)
            Capsule()
                .fill(Color.white)
                .frame(width: 30, height: 3)
        }
    }
}



//
// MARK: Boton Cruz (Menu)
//

struct BotonCruz: View {
    
    var body: some View {
        
        VStack(spacing: 5) {
            Capsule()
                .fill(Color.white)
                .frame(width: 35, height: 3)
                .rotationEffect(.init(degrees: -45))
                .offset(x: 0, y: 8)
            
            
            Capsule()
                .fill(Color.white)
                .frame(width: 35, height: 3)
                .rotationEffect(.init(degrees: 45))
            
        }
    }
}



//
// MARK: Full Screen Return Home Layer
//

struct FullScreenReturnHomeLayer: View {
    
    @Binding var isSelectingDrink: Bool
    
    var body: some View {
        
        let layer = BackgroundView(topColor: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), bottomColor: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), isHorizontal: false)
        
        Button(action: {
            withAnimation(.spring(), {
                isSelectingDrink.toggle()
            })
            
        }, label: {
            layer
        })
    }
}



//
// MARK: Mini Return Home Layer
//

struct MiniReturnHomeLayer: View {
    
    @Binding var isShowingMenu: Bool
    
    var body: some View {
        
        let layer = BackgroundView(topColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.01488226232)), bottomColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.01488226232)), isHorizontal: false)
        
        Button(action: {
            withAnimation(.spring(), {
                isShowingMenu.toggle()
            })
            
        }, label: {
            layer
        })
    }
}



//
// MARK: Divisor Ancho Horizontal
//

struct WiderDivisorHorizontal: View {
    
    var color: Color = .gray
    var width: CGFloat = 5
    var height: CGFloat = .infinity
    var opacity: Double = 1
    
    var body: some View {
        Rectangle()
            .fill(color)
            .opacity(opacity)
            .frame(width: height, height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}



//
// MARK: Divisor Ancho Vertical
//

struct WiderDivisorVertical: View {
    
    var color: Color = .gray
    var width: CGFloat = 5
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width)
            .edgesIgnoringSafeArea(.vertical)
    }
}
