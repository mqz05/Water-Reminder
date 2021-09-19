//
//  TiposDeBebidasData.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 11/06/2021.
//

import SwiftUI


//
// MARK: Bebidas (Modelo)
//

struct Bebida: Identifiable {
    let id: Int
    let nombreImagen: String
    let nombreBebida: String
}

let bebidas = [Bebida(id: 1, nombreImagen: "Water", nombreBebida: "Water"),
               Bebida(id: 2, nombreImagen: "Soda", nombreBebida: "Soda"),
               Bebida(id: 3, nombreImagen: "Sport Drink", nombreBebida: "Sport Drink"),
               Bebida(id: 4, nombreImagen: "Milk", nombreBebida: "Milk"),
               Bebida(id: 5, nombreImagen: "Coffee", nombreBebida: "Coffee"),
               Bebida(id: 6, nombreImagen: "Tea", nombreBebida: "Tea"),
               Bebida(id: 7, nombreImagen: "Juice", nombreBebida: "Juice"),
               Bebida(id: 8, nombreImagen: "Lemonade", nombreBebida: "Lemonade"),
               Bebida(id: 9, nombreImagen: "Wine", nombreBebida: "Wine"),
               Bebida(id: 10, nombreImagen: "Beer", nombreBebida: "Beer")]
