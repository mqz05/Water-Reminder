//
//  WaterCalculatorModel.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 19/9/21.
//

import SwiftUI


var pickerAge: CustomPicker!

var pickerWeight: CustomPicker!


enum Gender {
    case notSelected, male, female
}

var ageData: Array<Int> {
    var a = [1]
    
    for i in 2...80 {
        a.append(i)
    }
    
    return a
}

var weightData: Array<Int> {
    var a = [10]
    
    for i in 11...180 {
        a.append(i)
    }
    
    return a
}

/*
 
 FORMULAS:
    
    · Agua diaria recomendada (por peso y edad):
 
                <     ((35 ml x Kg de peso) + (Cantidad de agua por edad)) / 2     >

 
    · Agua tras ejercicio recomendada (elegir una o ambas y sacar media):
 
                <  ((1.25 ml x Kcal quemada) + (750 ml x Horas de ejercicio)) / 2  >
 
    
    · Cantidad de agua total:
 
                <               Agua diaria  +  Agua tras ejercicio                >
 
 
 
TEXTO AYUDA / TIPS:
 
    - The best way to know if you are dehydrated or properly hydrated is through urine, therefore, it is important to take into account the frequency with which you go to the bathroom and the color that it has. For example, if your urine is very light yellow, it indicates that you are properly hydrated. On the other hand, a dark yellow color in the urine and a strong smell, shows that you need to drink more water.
 
    - In case of noticing dry skin and lips, feeling fatigue and not being able to concentrate during day-to-day activities, it is also advisable to increase water consumption, since these are clear symptoms of dehydration.
 
    Datos (cantidad de agua por edad) basado en "EFSA": https://efsa.onlinelibrary.wiley.com/doi/pdf/10.2903/j.efsa.2010.1459
    
    * This quantity is just an aproximation. The exact value can vary depending on the specific circumstances of each one (for example the temperature and the humidity, the age, the metabolism, the physical activities performed, etc. For further information visit a doctor or profesional licensed  *
 
 
 
*/
