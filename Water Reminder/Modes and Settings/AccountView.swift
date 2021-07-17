//
//  AccountView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 15/7/21.
//

import SwiftUI
import FirebaseAuth
//import FirebaseFirestore

class AppViewModel: ObservableObject {
    
    //let db = Firestore.firestore()
    
    let auth = Auth.auth()
    
    @Published var loggedIn = false
    
    var isLogedIn: Bool {
        return auth.currentUser != nil
    }
    
    func logIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                // Success
                self?.loggedIn = true
            }
        }
    }
    
    func register(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                // Success
                self?.loggedIn = true
            }
        }
    }
    
    func logOut() {
        try? auth.signOut()
        
        self.loggedIn = false
    }
}


struct AccountView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var isLoggingIn = true
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ZStack {
            AccountBackground(isLoggingIn: $isLoggingIn)
            
            DataView(isLoggingIn: $isLoggingIn).animation(.spring())
            
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

/*
 struct AccountView_Previews: PreviewProvider {
 static var previews: some View {
 AccountBackground()
 }
 }*/

struct DataView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @Binding var isLoggingIn: Bool
    
    var body: some View {
        
        if isLoggingIn {
            LogInData().offset(y: 316)
        } else {
            RegisterData().offset(y: 200)
        }
        
    }
}

struct AccountBackground: View {
    
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
                    
                    Button(action: {
                        
                        isLoggingIn = true
                        
                    }, label: {
                        ZStack {
                            Text("Log In")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .scaleEffect(1.35)
                                .frame(width: 415, height: 225)
                        }
                    }).offset(x: 150, y: 60)
                }
                
                ZStack {
                    Ellipse()
                        .fill(isLoggingIn ? Color(#colorLiteral(red: 0.1725224555, green: 0.489376545, blue: 0.9920024276, alpha: 1)) : Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)))
                        .frame(width: 850, height: 675)
                        .rotationEffect(.init(degrees: -45))
                        .ignoresSafeArea()
                        .offset(x: -70, y: -175)
                    
                    Button(action: {
                        isLoggingIn = false
                    }, label: {
                        Text("Register")
                            .font(.title)
                            .fontWeight(.heavy)
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
                    .animation(.spring())
                    .offset(x: -135)
                    .frame(width: 860, height: 1025)
                    .rotationEffect(.init(degrees: 90))
                    .ignoresSafeArea()
                
                Ellipse()
                    .fill(Color(#colorLiteral(red: 0.06369515508, green: 0.1213632151, blue: 0.2552801967, alpha: 1)))
                    .opacity(isLoggingIn ? 0.08 : 1)
                    .animation(.spring())
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

struct RegisterData: View {
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var nickname = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack(spacing: 65) {
            VStack(spacing: 35) {
                SeccionDatos(titulo: "Nickname", contenido: $nickname, isPassword: false)
                
                SeccionDatos(titulo: "Email Address", contenido: $email, isPassword: false)
                
                SeccionDatos(titulo: "Password", contenido: $password, isPassword: true)
                
                SeccionDatos(titulo: "Confirm Password", contenido: $confirmPassword, isPassword: true)
                
            }
            Button(action: {
                
                guard !email.isEmpty, !password.isEmpty, password == confirmPassword else {
                    return
                }
                
                viewModel.register(email: email, password: password)
                
                /*viewModel.db.collection("usuarios").document(email).setData([
                 "Nickname": ""])*/
                
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

struct LogInData: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
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
                
                viewModel.logIn(email: email, password: password)
                
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

struct SeccionDatos: View {
    
    var titulo: String!
    @Binding var contenido: String
    var isPassword: Bool!
    
    @EnvironmentObject var viewModel: AppViewModel
    
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
