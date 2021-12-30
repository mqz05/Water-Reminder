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
    
    @Published var drinkDataToAdd: (String, Int) = ("", 0)
    
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
    
    
    // Stats Data (Daily)
    @Published var selectedDateData = SelectedDateWaterData(amountConsumed: 0, percentage: 0, typesOfDrinksAmount: [("", 0)], exists: false)
    
    // Stats Data (Weekly & Monthly)
    @Published var selectedWeekMonthData: SelectedWeekMonthWaterData = SelectedWeekMonthWaterData(amountConsumed: [], typesOfDrinksAmount: [])
    
    
    
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
        self.drinkDataToAdd.1 = 0
        
        self.loggedIn = false
    }
    
    
    // FUNCION: Sincronizar Datos del Perfil
    
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
    
    
    // FUNCION: Sincronizar Datos Generales
    
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
    
    
    // FUNCION: Actualizar Datos "Daily Mode"
    
    func updateUserDailyData() {
        
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
                
                let dayData = self.db.collection("usuarios").document(self.userEmail ?? "").collection("Daily data").document(self.currentDate)
                    
                dayData.updateData([
                    "Daily_Water_Amount" : self.userData.dailyWaterAmount,
                    self.drinkDataToAdd.0: self.drinkDataToAdd.1
                ])
                
                
            } else {
                
                self.db.collection("usuarios").document(self.userEmail ?? "").collection("Daily data").document(self.currentDate).setData([
                    "Daily_Water_Amount" : self.userData.dailyWaterAmount
                ])
            }
        })
    }
    
    // FUNCION: Actualizar Objetivo Diario
    
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
    
    // FUNCION: Anadir Cantidad de Agua
    
    func addWaterAmountToTotal()  {
        withAnimation(.linear(duration: 2)) {
            self.userData.dailyWaterAmount += self.drinkDataToAdd.1
            self.porcentaje = CGFloat(self.userData.dailyWaterAmount * 100 / self.userData.dailyWaterObjective)
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {_ in
            self.drinkDataToAdd.1 = 0
        })
    }
    
    // FUNCION: Obtener Datos de una Fecha
    
    func setDataFromDate(date: Date) {
        
        // Check if Logged In
        guard isLogedIn == true else {
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        let selectedDate = formatter.string(from: date)
        
        
        db.collection("usuarios").document(userEmail ?? "").collection("Daily data").document(selectedDate).getDocument(completion: { [self] document, error in
            
            guard error == nil else {
                print("error", error ?? "")
                self.selectedDateData.exists = false
                return
            }
            
            if let document = document, document.exists {
                
                let data = document.data()
                
                if let data = data {
                    
                    let amountConsumed = data["Daily_Water_Amount"] as? Int ?? 0
                    
                    if amountConsumed != 0 {
                        
                        let percentage = (amountConsumed * 100) / self.userData.dailyWaterObjective
                        
                        self.selectedDateData.amountConsumed = amountConsumed
                        self.selectedDateData.percentage = percentage
                        
                        
                        for (_, value) in data.enumerated() {
                            if value.key != "Daily_Water_Amount" {
                                self.selectedDateData.typesOfDrinksAmount.append((value.key, value.value as? Double ?? 0.0))
                            }
                        }
                        
                        self.selectedDateData.typesOfDrinksAmount.remove(at: 0)
                        
                        self.selectedDateData.exists = true
                        
                    } else {
                        self.selectedDateData.exists = false
                    }
                }
            } else {
                self.selectedDateData.exists = false
            }
        })
    }
    
    
    // FUNCION: Obtener Datos de un Mes
    
    func getDataFromDates(dates: [DateValueModel]) {
        
        // Check if Logged In
        guard isLogedIn == true else {
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        self.selectedWeekMonthData = SelectedWeekMonthWaterData(amountConsumed: [], typesOfDrinksAmount: [])
        
        var mergedData: [String : Int]? = [:]
        
        
        for i in 0...(dates.count - 1) {
            
                
            let selectedDate = formatter.string(from: dates[i].date)
            
            db.collection("usuarios").document(userEmail ?? "").collection("Daily data").document(selectedDate).getDocument(completion: { [self] document, error in
                
                guard error == nil else {
                    print("error", error ?? "")
                    return
                }
                
                if let document = document, document.exists {
                    
                    let data = document.data()
                    
                    if var data = data {
                        
                        let amountConsumed = data["Daily_Water_Amount"] as? Int ?? 0
                        
                        if amountConsumed != 0 {
                            
                            selectedWeekMonthData.amountConsumed.append((CGFloat(amountConsumed), dates[i].day))
                            
                            
                            // Remove Daily Water
                            data.removeValue(forKey: "Daily_Water_Amount")
                            
                            // Merge all types of drinks to one array
                            mergedData?.merge(data as! [String : Int]) { (current, new) in (current + new) }
                            
                        } else {
                            selectedWeekMonthData.amountConsumed.append((0, dates[i].day))
                        }
                    }
                } else {
                    selectedWeekMonthData.amountConsumed.append((0, dates[i].day))
                }
            })
                
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            
            guard let mergedData = mergedData else {
                return
            }
            
            var orderData: [(String, Int)] = []
            
            for (_, value) in mergedData.enumerated() {
                
                orderData.append((value.key, value.value))
                
            }
            
            self.selectedWeekMonthData.typesOfDrinksAmount = orderData.sorted {
                ($0.1, $0.0) > ($1.1, $1.0)
              }
        })
        
    }
    
}
