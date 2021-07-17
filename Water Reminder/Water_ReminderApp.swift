//
//  Water_ReminderApp.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 05/03/2021.
//

import SwiftUI
import Firebase

@main
struct Water_ReminderApp: App {
    /*
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate*/
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            MainView()
                .environmentObject(viewModel)
        }
    }
}
/*
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
         
        return true
    }
}*/
