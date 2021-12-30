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
    var isPassword: Bool = false
    
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

struct CustomDataField: View {
    
    @ObservedObject var text = TextCondition()
    
    var title: String
    
    var isPassword: Bool
    
    var width: CGFloat = 400
    
    @State var isTapped = false
    
    @State var isShowingPassword = false
    
    var body: some View {
        VStack {
            
            VStack(alignment: .center, spacing: 4) {
                
                HStack(spacing: 15) {
                    
                    TextField("", text: $text.value) { (status) in
                        if status {
                            withAnimation(.easeIn, {
                                isTapped = true
                            })
                        }
                    } onCommit: {
                        if text.value == "" {
                            withAnimation(.easeOut, {
                                isTapped = false
                            })
                        }
                    }
                    
                    if isPassword {
                        Button(action: {
                            if isShowingPassword {
                                isShowingPassword = false
                            } else {
                                isShowingPassword = true
                            }
                            
                        }, label: {
                            Image(systemName: isShowingPassword ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        })
                    }
                }
                .frame(width: width)
                .padding(.top, isTapped ? 15 : 0)
                .background(
                    
                    Text(title)
                        .scaleEffect(isTapped ? 0.8 : 1)
                        .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
                        .foregroundColor(isTapped ? Color.accentColor : Color.gray)
                    
                    
                    , alignment: .leading
                )
                
                .padding(.horizontal)
                
                Rectangle()
                    .fill(isTapped ? Color.accentColor : Color.gray)
                    .opacity(isTapped ? 1 : 0.5)
                    .frame(width: width, height: 1)
                    .padding(.top, 10)
                
            }
            .padding(.top, 15)
            .background(Color.gray.opacity(0.09))
            .cornerRadius(10)
            
        }
    }
}

class TextCondition: ObservableObject {
    @Published var value = "" /* {
     didSet {
     let filtered = value.filter { $0.isNumber }
     
     if value != filtered {
     value = filtered
     }
     }
     }*/
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
// MARK: Wave Background
//

struct WaveBackground: Shape {
    let graphWidth: CGFloat
    let amplitude: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        let origin = CGPoint(x: 0, y: height * 0.50)
        
        var path = Path()
        path.move(to: origin)
        
        var endY: CGFloat = 0.0
        let step = 5.0
        for angle in stride(from: step, through: Double(width) * (step * step), by: step) {
            let x = origin.x + CGFloat(angle/360.0) * width * graphWidth
            let y = origin.y - CGFloat(sin(angle/180.0 * Double.pi)) * height * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
            endY = y
        }
        path.addLine(to: CGPoint(x: width, y: endY))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: origin.y))
        
        return path
    }
}



//
// MARK: Fondo con Borde Redondeado
//

struct FondoBordeRedondeado: View {
    
    var fondo: Color
    
    var borde: Color
    
    var width: CGFloat
    var height: CGFloat
    
    var scaleX: CGFloat
    var scaleY: CGFloat
    
    var radio: CGFloat
    
    var body: some View {
        ZStack {
            borde
                .frame(width: width, height: height)
                .clipShape(EsquinasRedondeadas(esquinas: .allCorners, radio: radio))
                .scaleEffect(x: scaleX, y: scaleY)
            
            fondo
                .frame(width: width, height: height)
                .clipShape(EsquinasRedondeadas(esquinas: .allCorners, radio: radio))
        }
    }
}



//
// MARK: Fondo Degradado
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



struct DiscontinousLine: View {
    
    var width: CGFloat
    
    
    var body: some View {
        Path { path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
        }.stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
            .frame(height: 1.5)
    }
}

/*


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
*/
