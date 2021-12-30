//
//  LineGraph.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 22/10/21.
//

import SwiftUI
import grpc

struct LineGraph: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    var amountData: Array<CGFloat>
    
    var dateData: Array<String>
    
    var offsetIndex: Int
    
    var objectiveOffsetIndex: Int
    
    @State var currentPlot = ""
    
    @State var offset: CGSize = .zero
    
    @State var showPlot = false
    
    @State var translation: CGFloat = 0
    
    @State var index: Int = 1
    
    var body: some View {
        
        let maxData = amountData.max() ?? 0
        
        let maxPoint = maxData < CGFloat(firebaseViewModel.userData.dailyWaterObjective) ? CGFloat(firebaseViewModel.userData.dailyWaterObjective) : maxData + 400
        
        GeometryReader { proxy in
            
            let height = proxy.size.height
            let width = (proxy.size.width) / CGFloat(amountData.count - 1)
            
            let points = amountData.enumerated().compactMap { item -> CGPoint in
                
                let progress = item.element / maxPoint
                
                let pathHeight = progress * height
                
                let pathWidth = width * CGFloat(item.offset)
                
                return CGPoint(x: pathWidth, y: -pathHeight + height)
            }
            
            ZStack {
                
                Path { path in
                    
                    path.move(to: CGPoint(x: 0, y: 0))
                    
                    path.addLines(points)
                }
                .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                .fill(Color.magenta)
                
                fillBackground()
                    .clipShape(
                        Path { path in
                            
                            path.move(to: CGPoint(x: 0, y: 0))
                            
                            path.addLines(points)
                            
                            path.addLine(to: CGPoint(x: proxy.size.width, y: height))
                            
                            path.addLine(to: CGPoint(x: 0, y: height))
                        })
                
                VStack {
                    
                    Spacer()
                    
                    DiscontinousLine(width: proxy.size.width)
                        .offset(y: -(300 * (CGFloat(firebaseViewModel.userData.dailyWaterObjective) / maxPoint)))
                        .opacity(0.65)
                        .overlay(
                            index > amountData.count - (1 + objectiveOffsetIndex) && showPlot == true && pointPosition(maxData: maxData) == 2
                            ? nil
                            : HStack {
                                Spacer()
                                
                                Text("Objective")
                                    .font(.custom("NewAcademy", size: 16))
                                    .padding(.trailing, 5)
                                    .opacity(0.65)
                            }.offset(y: -(300 * (CGFloat(firebaseViewModel.userData.dailyWaterObjective) / maxPoint)) - 15)
                        )
                    
                    
                }.frame(height: 300)
                
                
            }
            .overlay (
                
                VStack(spacing: 0) {
                    
                    Text(currentPlot)
                        .font(.custom("NewAcademy", size: 18))
                        .frame(width: 100, height: 30)
                        .foregroundColor(.white)
                        .background(Color.purpleMagenta, in: Capsule())
                        .offset(x: index <= (offsetIndex - 1) ? 30 : 0)
                        .offset(x: index >= (amountData.count - offsetIndex) ? -30 : 0)
                    
                    Text("(\(dateData[index]))")
                        .font(.custom("NewAcademy", size: 14))
                        .foregroundColor(.white)
                        .frame(width: 115, height: 10)
                        .padding(.top, 7)
                        .padding(.bottom)
                        .offset(x: index <= (offsetIndex - 1) ? 32 : 0)
                        .offset(x: index >= (amountData.count - offsetIndex) ? -32 : 0)
                    
                    Rectangle()
                        .fill(Color.purpleMagenta)
                        .frame(width: 1, height: pointPosition(maxData: maxData) == 2 ? 10 : 40)
                    
                    Circle()
                        .fill(Color.purpleMagenta)
                        .frame(width: 25, height: 25)
                        .overlay(
                            Circle()
                                .fill(.white)
                                .frame(width: 12, height: 12)
                        )
                    
                    Rectangle()
                        .fill(Color.purpleMagenta)
                        .frame(width: 1, height: pointPosition(maxData: maxData) == 1 ? 20 : 65)
                }
                    .frame(width: 80, height: 300, alignment: .bottom)
                
                    .offset(y: pointPosition(maxData: maxData) == 1 ? 5 : 55)
                    .offset(offset)
                    .opacity(showPlot ? 1 : 0)
                
                , alignment: .bottomLeading
            )
            .contentShape(Rectangle())
            .gesture(DragGesture().onChanged({ value in
                
                withAnimation { showPlot = true }
                
                let translation = value.location.x
                
                index = max(min(Int((translation / width).rounded()), amountData.count - 1), 0)
                
                currentPlot = "\(Int(amountData[index]))ml"
                self.translation = translation
                
                offset = CGSize(width: points[index].x - 40, height: points[index].y - height)
                
            }).onEnded({ value in
                
                withAnimation { showPlot = false}
                
            }))
        }
        .overlay(
            VStack(alignment: .leading) {
                
                withAnimation {
                    index <= offsetIndex && pointPosition(maxData: maxData) == 2 && showPlot == true
                    ? nil
                    : Text("\(Int(maxPoint)) ml").font(.custom("NewAcademy", size: 20)).foregroundColor(Color.primaryLightBlue2)
                }
                
                Spacer()
                
                Text("0 ml")
                    .font(.custom("NewAcademy", size: 20))
                    .foregroundColor(Color.primaryLightBlue2)
            }
                .frame(height: 325)
                .frame(maxWidth: .infinity, alignment: .leading)
        )
    }
    
    private func pointPosition(maxData: CGFloat) -> Int {
        
        var topData: CGFloat = 0
        
        if maxData > CGFloat((firebaseViewModel.userData.dailyWaterObjective / 3) * 2) {
            topData = maxData
        } else {
            topData = CGFloat(firebaseViewModel.userData.dailyWaterObjective)
        }
        
        if (amountData[index] > (topData / 3) * 2) {
            
            // More than 66 %
            return 2
            
        } else if (amountData[index] < (topData / 3)) {
            
            // Less than 33 %
            return 1
            
        } else {
            // Between 33 % & 66 %
            return 0
        }
    }
    
    @ViewBuilder
    func fillBackground() -> some View {
        
        LinearGradient(colors: [Color.magenta.opacity(0.8), Color.magenta.opacity(0.4)], startPoint: .top, endPoint: .bottom)
        
    }
}


struct LegendLineGraph: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    var totalAmount: CGFloat
    
    var totalObjective: Int
    
    var percentage: Double
    
    
    var body: some View {
        
        HStack(spacing: 25) {
            
            // Total Stats
            VStack {
                
                Text("Total")
                    .font(.custom("NewAcademy", size: 30))
                    .foregroundColor(Color.secondaryLightBlue1)
                
                Spacer()
                
                ZStack {
                    Rectangle()
                        .frame(width: 165, height: 190)
                        .cornerRadius(30)
                        .foregroundColor(.primaryBlue)
                    
                    VStack(spacing: 18) {
                        
                        VStack {
                            Text("\(Int(totalAmount)) ml")
                                .font(.custom("DaggerSquare", size: 22))
                                .foregroundColor(.secondaryLightBlue2)
                            
                            Capsule()
                                .frame(width: 135, height: 1)
                                .foregroundColor(.secondaryLightBlue2)
                            
                            Text("\(totalObjective) ml")
                                .font(.custom("DaggerSquare", size: 22))
                                .foregroundColor(.secondaryLightBlue2)
                        }
                        
                        Rectangle()
                            .frame(width: 180, height: 12)
                            .foregroundColor(.secondaryDarkBlue2)
                        
                        Text(String(format: "%.2f", percentage) + " %")
                            .font(.custom("DaggerSquare", size: 24))
                            .foregroundColor(.secondaryBlue)
                    }
                }
                Spacer()
            }
            
            Capsule()
                .frame(width: 2, height: 210)
                .foregroundColor(.white)
            
            // Drinks Stats
            VStack(alignment: .leading) {
                
                Text("Drinks")
                    .font(.custom("NewAcademy", size: 30))
                    .foregroundColor(Color.secondaryLightBlue1)
                
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHStack(spacing: 10) {
                        
                        ForEach(0..<firebaseViewModel.selectedWeekMonthData.typesOfDrinksAmount.count, id: \.self) { index in
                            
                            let value = firebaseViewModel.selectedWeekMonthData.typesOfDrinksAmount[index]
                            
                            withAnimation(.linear(duration: 0.75)) {
                                DrinkCardView(drink: value.0, amount: value.1)
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }.frame(width: 775, height: 250)
    }
    
    @ViewBuilder
    func DrinkCardView(drink: String, amount: Int) -> some View {
        
        ZStack {
            Rectangle()
                .cornerRadius(25)
                .frame(width: 160, height: 200)
                .foregroundColor(Color.purple)
            
            
            VStack(spacing: 10) {
                ZStack {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.primaryLightBlue3)
                    
                    Image(drink)
                        .resizable()
                        .frame(width: 90, height: 90)
                }
                
                Text(drink)
                    .font(.custom("DaggerSquare", size: 21))
                    .foregroundColor(.primaryLightBlue2)
                
                HStack(spacing: 8) {
                    HStack(spacing: 2) {
                        Text("\(amount)")
                            .font(.custom("DaggerSquare", size: 18))
                            .foregroundColor(.lightPurple2)
                        
                        Text("ml")
                            .font(.custom("DaggerSquare", size: 14))
                            .foregroundColor(.lightPurple2)
                    }
                    
                    Capsule()
                        .frame(width: 0.75, height: 35)
                        .foregroundColor(.lightPurple2)
                    
                    HStack(spacing: 2) {
                        Text(String(format: "%.1f", (CGFloat(amount) / totalAmount) * 100))
                            .font(.custom("DaggerSquare", size: 18))
                            .foregroundColor(.lightPurple2)
                        
                        Text("%")
                            .font(.custom("DaggerSquare", size: 14))
                            .foregroundColor(.lightPurple2)
                    }
                    
                }
            }
        }
    }
}
