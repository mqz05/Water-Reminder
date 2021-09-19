//
//  FirebaseData.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 19/7/21.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore


//
// MARK: Firebase User (View Model)
//

class FirebaseViewModel: ObservableObject {
    
    // Database
    let db = Firestore.firestore()
    
    let auth = Auth.auth()

    
    // User Info
    @Published var userEmail = Auth.auth().currentUser?.email
    
    @Published var userData: User = User(nickname: "Default", level: "Default", points: 0, dailyWaterAmount: 0, dailyWaterObjective: 2000)
    
    @Published var drinkAmountToAdd: Int = 0
    
    @Published var porcentaje: CGFloat = 0
    
    
    
    // Check if logged in
    @Published var loggedIn = false
    
    var isLogedIn: Bool { return auth.currentUser != nil }
    
    
    // Time Data
    var currentDate: String = ""
    
    func fetchDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        self.currentDate = formatter.string(from: Date())
    }
    
    
    // Init
    init() {
        self.fetchDate()
        self.fetchUserProfile()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.fetchUserData()
        })
        
    }
    
    
    // FUNCION: Iniciar Sesion
    
    func logIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                // Success
                self?.loggedIn = true
                self?.userEmail = Auth.auth().currentUser?.email
                self?.fetchUserProfile()
                self?.fetchUserData()
            }
        }
    }
    
    
    // FUNCION: Crear Cuenta
    
    func register(email: String, password: String, nickname: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async { [self] in
                // Success
                self?.loggedIn = true
                self?.userEmail = Auth.auth().currentUser?.email
                
                self?.db.collection("usuarios").document(email).setData([
                                                                    "Nickname": nickname,
                                                                    "Level": "Beginner",
                                                                    "Points": 0,
                                                                    "Daily_Water_Objective": 2000
                                                                    ])
                self?.fetchUserProfile()
                self?.fetchUserData()
            }
        }
    }
    
    
    // FUNCION: Cerrar Sesion
    
    func logOut() {
        try? auth.signOut()
        
        userData = User(nickname: "Default", level: "Default", points: 0, dailyWaterAmount: 0, dailyWaterObjective: 2000)
        self.porcentaje = 0
        self.drinkAmountToAdd = 0
        
        self.loggedIn = false
    }
    
    
    // FUNCION: Actualizar Datos
    
    func fetchUserProfile() {
        
        // Check if Logged In
        guard isLogedIn == true else {
            return
        }
        
        
        // Fetch User Profile Info
        db.collection("usuarios").document(userEmail ?? "").getDocument(completion: { document, error in
            
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    self.userData.nickname = data["Nickname"] as? String ?? ""
                    self.userData.level = data["Level"] as? String ?? ""
                    self.userData.points = data["Points"] as? Int ?? 0
                    self.userData.dailyWaterObjective = data["Daily_Water_Objective"] as? Int ?? 0
                }
            }
        })
    }
    
    
    
    func fetchUserData() {
        
        // Check if Logged In
        guard isLogedIn == true else {
            return
        }
        
        // Fetch User Data
        db.collection("usuarios").document(userEmail ?? "").collection("Daily data").document(self.currentDate).getDocument(completion: { document, error in
            
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                
                if let data = data {
                    self.userData.dailyWaterAmount = data["Daily_Water_Amount"] as? Int ?? 0
                    
                    withAnimation(.linear(duration: 2)) {
                        self.porcentaje = CGFloat(self.userData.dailyWaterAmount * 100 / self.userData.dailyWaterObjective)
                    }
                }
                
            } else {
                
                self.db.collection("usuarios").document(self.userEmail ?? "").collection("Daily data").document(self.currentDate).setData([
                    "Daily_Water_Amount" : 0
                ])
                
                withAnimation(.linear(duration: 2)) {
                    self.userData.dailyWaterAmount = 0
                    self.porcentaje = CGFloat(self.userData.dailyWaterAmount * 100 / self.userData.dailyWaterObjective)
                }
            }
        })
    }
    
    
    
    func updateUserData() {
        
        // Check if Logged In
        guard isLogedIn == true else {
            return
        }
        
        
        // Fetch User Data
        db.collection("usuarios").document(userEmail ?? "").collection("Daily data").document(currentDate).getDocument(completion: { document, error in
            
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                
                self.db.collection("usuarios").document(self.userEmail ?? "").collection("Daily data").document(self.currentDate).updateData([
                    "Daily_Water_Amount" : self.userData.dailyWaterAmount
                ])
                
            } else {
                
                self.db.collection("usuarios").document(self.userEmail ?? "").collection("Daily data").document(self.currentDate).updateData([
                    "Daily_Water_Amount" : self.userData.dailyWaterAmount
                ])
            }
        })
    }
    
    
    
    func setWaterObjective() {
        
        // Check if Logged In
        guard isLogedIn == true else {
            return
        }
        
        
        // Update Water Objective
        db.collection("usuarios").document(userEmail ?? "").getDocument(completion: { document, error in
            
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                
                self.db.collection("usuarios").document(self.userEmail ?? "").updateData([
                    "Daily_Water_Objective" : self.userData.dailyWaterObjective
                ])
            }
        })
    }
    
    
    
    func addWaterAmountToTotal()  {
        withAnimation(.linear(duration: 2)) {
            self.userData.dailyWaterAmount += self.drinkAmountToAdd
            self.porcentaje = CGFloat(self.userData.dailyWaterAmount * 100 / self.userData.dailyWaterObjective)
            self.drinkAmountToAdd = 0
        }
    }
}
