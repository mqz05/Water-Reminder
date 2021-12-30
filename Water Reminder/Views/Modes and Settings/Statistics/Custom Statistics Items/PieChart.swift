//
//  PieChart.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 9/10/21.
//

import SwiftUI

let pieChartColors = [Color.orange1, Color.orange2, Color.orange3, Color.orange4, Color.orange5, Color.orange6, Color.orange7, Color.orange8, Color.orange9, Color.orange10]


struct PieChart: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    let data: Array<(String, Double)>
    
    var body: some View {
        ZStack {
            ForEach(0...(data.count - 1), id: \.self) { index in
                
                let dataPercentage = data[index].1 / Double(firebaseViewModel.selectedDateData.amountConsumed)
                
                let acumulatedAmount: Double = data.prefix(index).map{ $0.1 }.reduce(0, +)
                
                let currentSectionDegree: Double = dataPercentage * 360
                let lastSectionDegree: Double = (acumulatedAmount / Double(firebaseViewModel.selectedDateData.amountConsumed)) * 360
                
                ZStack {
                    PieceOfPieChart(startDegree: lastSectionDegree, endDegree: lastSectionDegree + currentSectionDegree)
                        .fill(pieChartColors[index])
                        .scaleEffect(0.95)
                    
                    GeometryReader { geo in
                        
                        VStack(spacing: 2) {
                            
                            if dataPercentage > 0.05 {
                                Text(String(format: "%.1f", dataPercentage * 100) + "%")
                                    .font(.custom("DaggerSquare", size: CGFloat(38 * dataPercentage) + 22))
                                    .foregroundColor(Color.secondaryDarkBlue1)
                                
                                if dataPercentage > 0.15 {
                                    Text(data[index].0)
                                        .font(.custom("DaggerSquare", size: CGFloat(30 * dataPercentage) + 18))
                                        .foregroundColor(Color.secondaryDarkBlue1)
                                }
                            } else if dataPercentage > 0.015 {
                                Text("···")
                                    .font(.custom("DaggerSquare", size: 20))
                                    .foregroundColor(Color.secondaryDarkBlue1)
                            }
                            
                        }.position(getDiagonalPosition(in: geo.size, startDegree: lastSectionDegree, currentSectionDegree: currentSectionDegree))
                    }
                }
            }
        }
    }
    
    private func getDiagonalPosition(in geoSize: CGSize, startDegree: Double, currentSectionDegree: Double) -> CGPoint {
        
        let center = CGPoint(x: geoSize.width / 2, y: geoSize.height / 2)
        
        let radius = geoSize.width / 4
        
        let degree = startDegree + (currentSectionDegree / 2)
        
        let yCoord = radius * sin(CGFloat(degree) * (CGFloat.pi / 180))
        let xCoord = radius * cos(CGFloat(degree) * (CGFloat.pi / 180))
        
        if currentSectionDegree == 360 {
            return center
        } else {
            return CGPoint(x: center.x + xCoord, y: center.y + yCoord)
        }
    }
}

struct PieceOfPieChart: Shape {
    
    let startDegree: Double
    let endDegree: Double
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            
            p.move(to: center)
            p.addArc(center: center, radius: rect.width / 2, startAngle: Angle(degrees: startDegree), endAngle: Angle(degrees: endDegree), clockwise: false)
            
            p.closeSubpath()
        }
    }
}


struct LegendPieChart: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    let data: Array<(String, Double)>
    
    var body: some View {
        
        ZStack {
            
            let rows = Array(repeating: GridItem(.flexible()), count: 3)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 20) {
                    ForEach(0..<data.count) { i in
                        
                        let color = pieChartColors[i]
                        
                        let percentage: Double = (data[i].1 / Double(firebaseViewModel.selectedDateData.amountConsumed)) * 100
                        
                        HStack(spacing: 10) {
                            Circle()
                                .fill(color)
                                .frame(width: 15, height: 15)
                            
                            Text(data[i].0)
                                .font(.custom("DaggerSquare", size: 22))
                                .foregroundColor(color)
                            
                            Text("(" + String(format: "%.1f", percentage) + "%)")
                                .font(.custom("DaggerSquare", size: 20))
                                .foregroundColor(color)
                            
                        }.frame(width: 225, height: 20, alignment: .leading)
                    }
                }
            }
        }.frame(width: 540, height: 130)
    }
}
