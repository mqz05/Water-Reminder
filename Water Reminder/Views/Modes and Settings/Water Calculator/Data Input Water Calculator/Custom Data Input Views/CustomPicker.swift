//
//  CustomPicker.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 19/9/21.
//

import SwiftUI

struct CustomPickerFrame: View {
    
    var title: String
    
    let picker: CustomPicker
    
    
    init(title: String, picker: CustomPicker) {
        self.title = title
        self.picker = picker
    }
    
    var body: some View {
        ZStack {
            FondoBordeRedondeado(fondo: Color.primaryLightBlue2, borde: Color.primaryLightBlue1, width: 280, height: 280, scaleX: 1.08, scaleY: 1.08, radio: 45)
            
            VStack {
                Text(title)
                    .frame(width: 110, alignment: .leading)
                    .font(.custom("NewAcademy", size: 26))
                    .foregroundColor(.primaryDarkBlue)
                    .padding(.top, 20)
                    .offset(x: -55)
                
                picker
            }
        }
    }
}


//
// Custom Picker
//

struct CustomPicker: UIViewRepresentable {
    
    let picker = UIPickerView()
    
    
    var data: Array<Any>
    
    var width: CGFloat
    
    var valueName: String
    
    
    @Binding var selected: Any
    
    
    func makeCoordinator() -> Coordinator {
        return CustomPicker.Coordinator(parent: self, width: width, data: data, valueName: valueName)
    }
    
    func makeUIView(context: Context) -> UIPickerView {
        
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        
        if valueName == "Weight" {
            picker.selectRow(50, inComponent: 0, animated: false)
        }
        
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        
    }
    
    func resetPicker() {
        if valueName == "Weight" {
            picker.selectRow(50, inComponent: 0, animated: false)
        } else {
            picker.selectRow(0, inComponent: 0, animated: false)
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        var parent: CustomPicker
        
        var width: CGFloat
        
        var data: Array<Any>
        
        var valueName: String
        
        init(parent: CustomPicker, width: CGFloat, data: Array<Any>, valueName: String) {
            self.parent = parent
            self.width = width
            self.data = data
            self.valueName = valueName
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return data.count
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            
            pickerView.subviews[1].backgroundColor = UIColor.clear
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 60))
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            
            label.text = data[row] as! Int == 80 && valueName == "Age" ? "+80" : valueName == "Weight" ? "\(data[row])" + " kg" : "\(data[row])"
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont(name: "NewAcademy", size: 22)
            
            view.addSubview(label)
            
            view.clipsToBounds = true
            view.layer.cornerRadius = view.bounds.height / 2
            
            view.layer.borderWidth = 2.5
            view.layer.borderColor = UIColor.white.cgColor
            
            return view
        }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return width
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 67
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.selected = data[row]
        }
    }
}
