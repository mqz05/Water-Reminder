//
//  AccountView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 15/7/21.
//

import SwiftUI


//
// MARK: Cuenta de Usuario (Iniciar Sesion / Crear Cuenta)
//

struct AccountView: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @State var isLoggingIn = true
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ZStack {
            AccountViewBackground(isLoggingIn: $isLoggingIn)
            
            DataView(isLoggingIn: $isLoggingIn)
            
        }
        .frame(maxWidth: 834, maxHeight: 1194)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
            BotonCruz()
                .frame(width: 40, height: 30)
                .padding(.trailing, 15)
                .foregroundColor(.black)
                .offset(x: -5)
        }))
    }
}


//
// MARK: Formulario de Datos
//

struct DataView: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @Binding var isLoggingIn: Bool
    
    var body: some View {
        
        if isLoggingIn {
            LogInData().offset(y: 316)
        } else {
            RegisterData().offset(y: 200)
        }
    }
}


//
// MARK: Fondo de la View Cuenta de Usuario
//

struct AccountViewBackground: View {
    
    @Binding var isLoggingIn: Bool
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Ellipse()
                        .fill(isLoggingIn ? Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 0.1725224555, green: 0.489376545, blue: 0.9920024276, alpha: 1)))
                        .frame(width: 850, height: 675)
                        .rotationEffect(.init(degrees: 45))
                        .ignoresSafeArea()
                        .offset(x: 70, y: -175)
                    
                    Button(action: { isLoggingIn = true }, label: {                            Text("Log In")
                        .font(.custom("DaggerSquare", size: 34))
                        .foregroundColor(.white)
                        .scaleEffect(1.35)
                        .frame(width: 415, height: 225)
                        
                    }).offset(x: 150, y: 60)
                }
                
                ZStack {
                    Ellipse()
                        .fill(isLoggingIn ? Color(#colorLiteral(red: 0.1725224555, green: 0.489376545, blue: 0.9920024276, alpha: 1)) : Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)))
                        .frame(width: 850, height: 675)
                        .rotationEffect(.init(degrees: -45))
                        .ignoresSafeArea()
                        .offset(x: -70, y: -175)
                    
                    Button(action: { isLoggingIn = false }, label: {
                        Text("Register")
                            .font(.custom("DaggerSquare", size: 34))
                            .foregroundColor(.white)
                            .scaleEffect(1.35)
                            .frame(width: 415, height: 225)
                        
                    }).offset(x: -150, y: 60)
                }
            }.ignoresSafeArea()
            
            ZStack {
                Ellipse()
                    .fill(Color(#colorLiteral(red: 0.06369515508, green: 0.1213632151, blue: 0.2552801967, alpha: 1)))
                    .opacity(isLoggingIn ? 0.08 : 1)
                    .animation(.spring(), value: isLoggingIn)
                    .offset(x: -135)
                    .frame(width: 860, height: 1025)
                    .rotationEffect(.init(degrees: 90))
                    .ignoresSafeArea()
                
                Ellipse()
                    .fill(Color(#colorLiteral(red: 0.06369515508, green: 0.1213632151, blue: 0.2552801967, alpha: 1)))
                    .opacity(isLoggingIn ? 0.08 : 1)
                    .animation(.spring(), value: isLoggingIn)
                    .offset(x: -35)
                    .frame(width: 860, height: 1025)
                    .rotationEffect(.init(degrees: 90))
                    .ignoresSafeArea()
                
                Ellipse()
                    .fill(Color(#colorLiteral(red: 0.06369515508, green: 0.1213632151, blue: 0.2552801967, alpha: 1)))
                    .frame(width: 860, height: 1025)
                    .offset(x: 65)
                    .rotationEffect(.init(degrees: 90))
                    .ignoresSafeArea()
            }
            
        }.frame(maxWidth: 834, maxHeight: 1194)
        .background(Color(#colorLiteral(red: 0.9920526147, green: 0.992218554, blue: 0.9920293689, alpha: 1)))
        .ignoresSafeArea()
    }
}


//
// MARK: Crear Cuenta (Datos)
//

struct RegisterData: View {
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var nickname = ""
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    var body: some View {
        VStack(spacing: 65) {
            VStack(spacing: 35) {
                SeccionDatos(titulo: "Nickname", contenido: $nickname, isPassword: false)
                
                SeccionDatos(titulo: "Email Address", contenido: $email, isPassword: false)
                
                SeccionDatos(titulo: "Password", contenido: $password, isPassword: true)
                
                SeccionDatos(titulo: "Confirm Password", contenido: $confirmPassword, isPassword: true)
            }
            
            Button(action: {
                
                guard !nickname.isEmpty, !email.isEmpty, !password.isEmpty, password == confirmPassword else {
                    return
                }
                
                firebaseViewModel.register(email: email, password: password, nickname: nickname)
                
            }, label: {
                Text("Register")
                    .font(.custom("NewAcademy", size: 26))
                    .foregroundColor(.white)
                    .frame(width: 250, height: 60)
                    .background(
                        Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1))
                            .clipShape(EsquinasRedondeadas(esquinas: .allCorners, radio: 30))
                    )
            })
        }
    }
}


//
// MARK: Iniciar Sesion (Datos)
//

struct LogInData: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    var body: some View {
        VStack(spacing: 65) {
            VStack(spacing: 35) {
                SeccionDatos(titulo: "Email Address", contenido: $email, isPassword: false)
                
                SeccionDatos(titulo: "Password", contenido: $password, isPassword: true)
            }
            
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                
                firebaseViewModel.logIn(email: email, password: password)
                
            }, label: {
                Text("Log In")
                    .font(.custom("NewAcademy", size: 26))
                    .foregroundColor(.white)
                    .frame(width: 250, height: 60)
                    .background(
                        Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1))
                            .clipShape(EsquinasRedondeadas(esquinas: .allCorners, radio: 30))
                    )
            })
        }
    }
}
