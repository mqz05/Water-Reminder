//
//  DailyModeView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 07/03/2021.
//

import SwiftUI

struct DailyModeView: View {
    
    @State var addWaterAmount: Int = 0
    
    @State var totalWaterAmount: Int = 0
    
    @State var waterObjective: Int = 2000
    
    @State var porcentaje: CGFloat = 0
    
    @State var isSelectingDrink: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundView(topColor: Color(#colorLiteral(red: 0.4080183647, green: 0.6348306513, blue: 1, alpha: 1)), bottomColor: Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)), isHorizontal: false)
            
            VStack(spacing: 5) {
                TitleAndImage()
                
                DrinksMainButtonAndTitle(isSelectingDrink: $isSelectingDrink)
                    .allowsHitTesting(!isSelectingDrink)
                
                AddQuantityButtons(waterAmount: $addWaterAmount)
                    .allowsHitTesting(!isSelectingDrink)
                
                TotalAmountView(waterAmount: $addWaterAmount)
                
                AddAndResetButtons(addWaterAmount: $addWaterAmount, totalWaterAmount: $totalWaterAmount, waterObjective: $waterObjective, porcentaje: $porcentaje)
                    .allowsHitTesting(!isSelectingDrink)
            }
            
            BarraDeProgreso(porcentaje: $porcentaje)
            
            DesplegarBotonesDrinks(isSelectingDrink: $isSelectingDrink)
        }
    }
}
/*
struct DailyModeView_Previews: PreviewProvider {
    static var previews: some View {
        DailyModeView()
    }
}*/


//
// MARK: Titulo e Imagen
//

struct TitleAndImage: View {
    var body: some View {
        VStack(spacing: 5) {
            Text("Daily Mode")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color(#colorLiteral(red: 0.7302836776, green: 0.401488483, blue: 0.9478703141, alpha: 1)))
                .padding(.top, 15)
            
            Image("Imagen Prueba")
                .resizable()
                .frame(maxWidth: 500, maxHeight: 500)
                .clipShape(Circle())
                .overlay(Circle()
                    .stroke(Color.orange, lineWidth: 6))
                .shadow(color: Color.yellow, radius: 20)
                .padding(.vertical, 35.0)
                .padding(.bottom, 15)
        }
    }
}


//
// MARK: Boton Bebidas
//

struct DrinksMainButtonAndTitle: View {
    
    @Binding var isSelectingDrink: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Drinks")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color(#colorLiteral(red: 0.9992401004, green: 0.6269122958, blue: 0, alpha: 1)))
            
            Button(action: {
                // Desplegar todas las bebidas (Selector de Bebida)
                isSelectingDrink = true
                
            }, label: {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color(#colorLiteral(red: 0.9992401004, green: 0.6269122958, blue: 0, alpha: 1)), lineWidth: 6))
                    .foregroundColor(Color.white)
            })
        }
        .padding(.bottom, 30.0)
    }
}


//
// MARK: Botones para Seleccionar la Cantidad de Bebida
//

struct AddQuantityButtons: View {
    
    @Binding var waterAmount: Int
    
    var body: some View {
        HStack(spacing: 40) {
            
            ForEach(1..<6, id: \.self) { numeroBoton in
                
                Button(action: {
                    if numeroBoton == 1 {
                        // Añadir 10ml
                        self.waterAmount = self.waterAmount + 10
                        
                    } else if numeroBoton == 2 {
                        // Añadir 50ml
                        self.waterAmount = self.waterAmount + 50
                        
                    } else if numeroBoton == 3 {
                        // Añadir 100ml
                        self.waterAmount = self.waterAmount + 100
                        
                    } else if numeroBoton == 4 {
                        // Añadir 150ml
                        self.waterAmount = self.waterAmount + 150
                        
                    } else {
                        // Añadir 200ml
                        self.waterAmount = self.waterAmount + 200
                        
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(maxWidth: 100, maxHeight: 100)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color(#colorLiteral(red: 0.9992401004, green: 0.6269122958, blue: 0, alpha: 1)), lineWidth: 6))
                        .foregroundColor(Color.white)
                })
            }
        }
        .padding(.bottom, 30.0)
    }
}


//
// MARK: Vista de la Cantidad de Bebida Seleccionada
//

struct TotalAmountView: View {
    
    @Binding var waterAmount: Int
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Total Amount:")
            Text("\(waterAmount) ml")
                .padding(5)
                .border(Color.white, width: 3)
        }
        .padding(.bottom, 25)
    }
}


//
// MARK: Boton Añadir Cantidad de Bebida al Total
//

struct AddAndResetButtons: View {
    
    @Binding var addWaterAmount: Int
    
    @Binding var totalWaterAmount: Int
    
    @Binding var waterObjective: Int
    
    @Binding var porcentaje: CGFloat
    
    @State private var showConfirmation: Bool = false
    
    var body: some View {
        HStack {
            Button(action: {
                // Añadir Cantidad (Boton Add)
                self.showConfirmation = true
                
            }, label: {
                Image(systemName: "plus.rectangle.fill")
                    .resizable()
                    .frame(maxWidth: 125, maxHeight: 100)
                    .foregroundColor(Color.white)
                    .cornerRadius(25)
            })
                .padding(.leading, 250)
            
            Button(action: {
                // Restablecer Cantidad (Boton Reset)
                self.addWaterAmount = 0
                
            }, label: {
                Image(systemName: "minus.circle.fill")
                    .resizable()
                    .frame(maxWidth: 100, maxHeight: 75)
                    .foregroundColor(Color.white)
            })
                .padding(.leading, 150)
        }
        .padding(.bottom, 5.0)
            
            // Alerta de confirmacion para añadir cantidad de bebida al total
        .alert(isPresented: $showConfirmation, content: {
            if addWaterAmount > 0 {
                return Alert(
                    title: Text("Do you want to add this amount?"),
                    message: Text("Check the quantity"),
                    primaryButton: .default(Text("Add")) {
                        self.totalWaterAmount = self.totalWaterAmount + self.addWaterAmount
                        self.addWaterAmount = 0
                        self.porcentaje = self.calcularPorcentaje() / 100
                    },
                    secondaryButton: .cancel()
                )
            } else {
                return Alert(title: Text("Select a amount to add"), dismissButton: .cancel(Text("Return")))
            }
        })
    }
    
    // FUNCION: calcular el porcentaje para la barra de progreso
    func calcularPorcentaje() -> CGFloat {
        let nuevoPorcentaje = totalWaterAmount * 100 / waterObjective
        
        return CGFloat(nuevoPorcentaje)
    }
}


//
// MARK: Barra de Progreso
//

struct BarraDeProgreso: View {
    
    @Binding var porcentaje: CGFloat
    
    var body: some View {
        
        ZStack() {
            
            Capsule().fill(Color.black.opacity(0.8))
                .frame(width: 52, height: 702)
            
            ZStack(alignment: .bottom) {
                Capsule().fill(Color(#colorLiteral(red: 0.755085593, green: 0.7882685688, blue: 0.8353505505, alpha: 1)))
                    .frame(width: 50, height: 700)
                
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .bottom, endPoint: .top))
                    .frame(width: 50, height: cambiarBarraPorcentaje())
                
            }
            Text(String(format: "%.0f", self.porcentaje * 100) + "%")
                .offset(y: -320)
            
        }.offset(x: 355, y: -190)
    }
    
    // FUNCION: Calcular el cambio de la barra de progreso
    func cambiarBarraPorcentaje() -> CGFloat {
        let altura = 700
        var nuevoTamaño = CGFloat(altura) * self.porcentaje
        
        if nuevoTamaño > 700 {
            nuevoTamaño = 700
        }
        
        return nuevoTamaño
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
// MARK: Desplegar Botones Drinks
//

struct DesplegarBotonesDrinks: View {
    
    @Binding var isSelectingDrink: Bool
    
    var body: some View {
        ZStack {
            if isSelectingDrink == true {
                
                FullScreenReturnHomeLayer(isSelectingDrink: $isSelectingDrink)
                    .opacity(0.25)
                
                
                //
                //Añadir fondo detras de los botones de las bebidas
                //
                
                
                ScrollViewBotonesBebidas()
                    .offset(y: 250)
                    .scaleEffect(x: 0.8, y: 0.8)
                
                
            }
        }
    }
}
// FUNCION: Sacar la escala de los botones
private func sacarEscalaBotones(geometria: GeometryProxy) -> CGFloat {
    var escala: CGFloat = 1
    
    let x = geometria.frame(in: .global).minX
    
    if x > 0 && x <= 417 {
        escala = 1 + (abs((x) / 200) * 0.45)
    } else if x > 417 && x < 834 {
        escala = 1 + (abs((x - 834) / 200) * 0.45)
    }
    
    return escala
}

// FUNCION: Sacar coordenadas del offset de los botones
private func sacarCoordsOffset(geometria: GeometryProxy) -> Double {
    let x = geometria.frame(in: .global).midX
    
    let left = x < 278 && x > 100
    let moreLeft = x <= 100
    
    let right = x > 556 && x < 734
    let moreRight = x >= 734
    
    let posicion = (x - 417)
    
    var numero = Double(posicion * 0.3)
    
    if left == true || right == true {
        numero = Double(posicion * 0.1)
    }else if moreLeft == true || moreRight == true {
        numero = Double(posicion * -0.05)
    }
    
    return numero
}

//
// MARK: Botones Drinks
//

struct BotonesSeleccionarDrinks: View {
    
    var id: Int
    var nombreImagen: String
    var nombreBebida: String
    //@Binding var isTouching: Bool
    
    var body: some View {
        
            GeometryReader { geometry in
                
                let angulo = Double((geometry.frame(in: .global).minX - 350) / 6)
                
                OtherDrinksButton(id: id, nombreImagen: nombreImagen, nombreBebida: nombreBebida/*, isTouching: $isTouching*/)
                    .padding(.leading, 25)
                    .rotation3DEffect(
                        Angle(degrees: angulo > 70 ? 70 : angulo < -70 ? -70 : angulo),
                        axis: (x: 0, y: 0.1, z: 0))
                    .scaleEffect(x: sacarEscalaBotones(geometria: geometry), y: sacarEscalaBotones(geometria: geometry))
                    .offset(x: CGFloat(sacarCoordsOffset(geometria: geometry)), y: 0)
                    .animation(.spring())
                    
                    
                
            }.frame(width: 150, height: 225, alignment: .center)
            .padding(.top, 50)
            //.overlay(Rectangle().stroke(Color.red, lineWidth: 4))
        }
        
    
}


//
// MARK: Scroll View Botones Bebidas
//

struct ScrollViewBotonesBebidas: View {
    
    @ObservedObject var tiposDeBebidas = TiposDeBebidaTotales()
    
    @State var cargandoScrollView = true
    
    @State var isTouching = false
    
    init() {
        tiposDeBebidas.añadirBebidas(at: 0)
    }
    
    var body: some View {
        
        //let tap = DragGesture(minimumDistance: 0)
        //            .updating($isTouching) { (_, isTouching, _) in
        //                isTouching = true
        //            }
        ZStack {
        ScrollViewReader { scrollView in
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                LazyHStack(spacing: 30) {
            
                    ForEach(tiposDeBebidas.bebida.indices, id: \.self) { indiceBebida in
                        
                        let bebida = tiposDeBebidas.bebida[indiceBebida]
                        
                        BotonesSeleccionarDrinks(id: bebida.id, nombreImagen: bebida.nombreImagen, nombreBebida: bebida.bebida/*, isTouching: $isTouching*/).onAppear {
                            /*print(tiposDeBebidas.bebida.count)
                            print(indiceBebida)
                            
                            // NO VA
                            print(isTouching)
                            */
                            
                            /// DEBUG
                            
                                if bebida.id == -2 {
                                    withAnimation(.spring(), {
                                        scrollView.scrollTo(11, anchor: .center)
                                        //!cargandoScrollView ? //esperarParaMover(isTouching: isTouching, scrollView: scrollView, to: 11)/*scrollView.scrollTo(11, anchor: .center)*/ : nil
                                    })
                                    
                                    
                                } else if bebida.id == 12 {
                                    withAnimation(.spring(), {
                                        scrollView.scrollTo(3, anchor: .center)
                                        //!cargandoScrollView ? //esperarParaMover(isTouching: isTouching, scrollView: scrollView, to: 3) /*scrollView.scrollTo(3, anchor: .center)*/ : nil
                                    })
                                }
                            /*
                             if (indiceBebida + 1).isMultiple(of: 9) {
                             tiposDeBebidas.añadirBebidas(at: 1)
                             
                             
                             } else if indiceBebida == 0 {
                             tiposDeBebidas.añadirBebidas(at: 2)
                             
                             }*/
                        }
                        
                                    /*DragGesture(minimumDistance: 0)
                                        .onChanged { value in
                                            isTouching = true
                                            print("comieza un toque")
                                        }
                                        .onEnded { value in
                                            isTouching = false
                                            print("acaba el toque")
                                        }
                                )*/
                    }
                }.onAppear {
                    withAnimation(.spring(), {
                        scrollView.scrollTo(3, anchor: .center)
                    })
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.cargandoScrollView = false
                        print("CARGANDO")
                    })
                    
                }
                
            }.frame(width: 680, height: 275)
            /*.simultaneousGesture(DragGesture().onEnded({ _ in
                // if keyboard is opened then hide it
                print("HEYYYYY SOLTADO 1")
            })).simultaneousGesture(DragGesture().onChanged({ _ in
                // if keyboard is opened then hide it
                print("HEYYYYY PULSADO 1")
            }))
            .gesture(
             DragGesture(minimumDistance: 0)
             .onChanged { value in
                 //isTouching = true
                 print("comieza un toque")
             }
             .onEnded { value in
                 //isTouching = false
                 print("acaba el toque")
             }
     )*/
            
           /*
        }.simultaneousGesture(DragGesture().onEnded({ _ in
            // if keyboard is opened then hide it
            print("HEYYYYY SOLTADO 2")
        })).simultaneousGesture(DragGesture().onChanged({ _ in
            // if keyboard is opened then hide it
            print("HEYYYYY PULSADO 2")
        }))
    }.simultaneousGesture(DragGesture().onEnded({ _ in
        // if keyboard is opened then hide it
        print("HEYYYYY SOLTADO")
    })).simultaneousGesture(DragGesture().onChanged({ _ in
        // if keyboard is opened then hide it
        print("HEYYYYY PULSADO")
    }))
    }*/
    
}
        }
    }
}
/*
func esperarParaMover(isTouching: Bool, scrollView: ScrollViewProxy, to postion: Int) {
    print("probando")
    if !isTouching {
        scrollView.scrollTo(postion, anchor: .center)
        print("moviendo")
    } else {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            esperarParaMover(isTouching: isTouching, scrollView: scrollView, to: postion)
            print("volviendo a probar...")
        })
    }
    
}*/

//
// MARK: Modelos Botones
//

struct OtherDrinksButton: View {
    
    var id: Int
    var nombreImagen: String
    var nombreBebida: String
    
    //@Binding var isTouching: Bool
    
    var body: some View {
        
        
        Button(action: {
            
            
            //NO VA
            //isTouching.toggle()
            //print(isTouching)
        }, label: {
            VStack {
                Text("\(id)")
            Image(systemName: "play.circle.fill")
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
                .clipShape(Circle())
                .overlay(Circle()
                            .stroke(Color(#colorLiteral(red: 0.9992401004, green: 0.6269122958, blue: 0, alpha: 1)), lineWidth: 6))
                .foregroundColor(Color.white)
            }
        })
            
        
    }
}
