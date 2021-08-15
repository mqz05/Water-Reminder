//
//  DrinksViewModel.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 8/8/21.
//

import SwiftUI


//
// MARK: Datos Bebidas
//

class TiposDeBebidaTotales: ObservableObject {
    @Published var bebida = [Bebida]()
    
    func añadirBebidas(at index: Int) {
        
        switch index {
        case 0:
            bebida.append(contentsOf: [
                            Bebida(id: -2, nombreImagen: "Zumo", nombreBebida: "Juice"),
                            Bebida(id: -1, nombreImagen: "Vino", nombreBebida: "Wine"),
                            Bebida(id: 0, nombreImagen: "Cerveza", nombreBebida: "Beer"),
                            Bebida(id: 1, nombreImagen: "Agua", nombreBebida: "Water"),
                            Bebida(id: 2, nombreImagen: "Refresco", nombreBebida: "Soda"),
                            Bebida(id: 3, nombreImagen: "Bebida Energetica", nombreBebida: "Energy Drink"),
                            Bebida(id: 4, nombreImagen: "Leche", nombreBebida: "Milk"),
                            Bebida(id: 5, nombreImagen: "Cafe", nombreBebida: "Coffee"),
                            Bebida(id: 6, nombreImagen: "Te", nombreBebida: "Tea"),
                            Bebida(id: 7, nombreImagen: "Zumo", nombreBebida: "Juice"),
                            Bebida(id: 8, nombreImagen: "Vino", nombreBebida: "Wine"),
                            Bebida(id: 9, nombreImagen: "Cerveza", nombreBebida: "Beer"),
                            Bebida(id: 10, nombreImagen: "Agua", nombreBebida: "Water"),
                            Bebida(id: 11, nombreImagen: "Refresco", nombreBebida: "Soda"),
                            Bebida(id: 12, nombreImagen: "Bebida Energetica", nombreBebida: "Energy Drink")])
            
        case 1:
            bebida.append(contentsOf: [
                            Bebida(id: 1, nombreImagen: "Agua", nombreBebida: "Water"),
                            Bebida(id: 2, nombreImagen: "Refresco", nombreBebida: "Soda"),
                            Bebida(id: 3, nombreImagen: "Bebida Energetica", nombreBebida: "Energy Drink"),
                            Bebida(id: 4, nombreImagen: "Leche", nombreBebida: "Milk"),
                            Bebida(id: 5, nombreImagen: "Cafe", nombreBebida: "Coffee"),
                            Bebida(id: 6, nombreImagen: "Te", nombreBebida: "Tea"),
                            Bebida(id: 7, nombreImagen: "Zumo", nombreBebida: "Juice"),
                            Bebida(id: 8, nombreImagen: "Vino", nombreBebida: "Wine"),
                            Bebida(id: 9, nombreImagen: "Cerveza", nombreBebida: "Beer")])
            if bebida.count >= 27 {
                bebida.removeFirst(9)
            }
            
            
        case 2:
            bebida.insert(contentsOf: [
                            Bebida(id: 1, nombreImagen: "Agua", nombreBebida: "Water"),
                            Bebida(id: 2, nombreImagen: "Refresco", nombreBebida: "Soda"),
                            Bebida(id: 3, nombreImagen: "Bebida Energetica", nombreBebida: "Energy Drink"),
                            Bebida(id: 4, nombreImagen: "Leche", nombreBebida: "Milk"),
                            Bebida(id: 5, nombreImagen: "Cafe", nombreBebida: "Coffee"),
                            Bebida(id: 6, nombreImagen: "Te", nombreBebida: "Tea"),
                            Bebida(id: 7, nombreImagen: "Zumo", nombreBebida: "Juice"),
                            Bebida(id: 8, nombreImagen: "Vino", nombreBebida: "Wine"),
                            Bebida(id: 9, nombreImagen: "Cerveza", nombreBebida: "Beer")], at: 0)
            /*
            if bebida.count >= 27 {
                bebida.removeLast(9)
            }*/
        /*case 1:
            bebida.append(contentsOf: [
                            Bebida(id: 10, nombreImagen: "", bebida: "Water"),
                            Bebida(id: 11, nombreImagen: "", bebida: "Soda"),
                            Bebida(id: 12, nombreImagen: "", bebida: "Energy Drink"),
                            Bebida(id: 13, nombreImagen: "", bebida: "Milk"),
                            Bebida(id: 14, nombreImagen: "", bebida: "Coffee"),
                            Bebida(id: 15, nombreImagen: "", bebida: "Tea"),
                            Bebida(id: 16, nombreImagen: "", bebida: "Juice"),
                            Bebida(id: 17, nombreImagen: "", bebida: "Wine"),
                            Bebida(id: 18, nombreImagen: "", bebida: "Beer")])*/
        default:
            break
        }
        
    }
}
