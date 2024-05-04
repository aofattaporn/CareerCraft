//
//  AddJobView.swift
//  CareerCraft
//
//  Created by attaporn on 5/2/24.
//

import SwiftUI
import SwiftData

struct AddJobView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var companyName: String = ""
    @State private var departmentName: String = ""
    @State private var location: String = ""
    @State private var minSalary: String = ""
    @State private var maxSalary: String = ""
    @State private var workStyleIndex: Int = 3
    let workStyles:[WorkStyle] = [.onsite, .online, .hybrid]
    @State private var workTimeIndex: Int = 2
    let workTimes:[WorkTime]  = [.flexible, .fixed]
    
    @State private var hasbonusFrequency: Bool = false
    @State private var hasSocialSecurity: Bool = false
    @State private var hasProvidentFund: Bool = false
    @State private var hasEquipment: Bool = false


    
    var body: some View {
        
        VStack {
            
            
            HStack {
                Button(action: { dismiss() }) {
                    Text("Back")
                }
                
                Spacer()
                
                Button(action: {
                    addItem()
                    dismiss()
                }) {
                    Text("Save")
                        .disabled(companyName.isEmpty)
                }
            }
            .padding(.all)
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 0.0) {
                    
                    // Company Name
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Company Name")
                            .font(.headline)
                        HStack {
                            CustomTextField(text: $companyName, placeholder: "Enter company name")
                        }
                    }
                    .padding()
                    
                    // Department Name
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Department Name")
                            .font(.headline)
                        HStack {
                            CustomTextField(text: $departmentName, placeholder: "Enter department name")
                        }
                    }
                    .padding()
                    
                    
                    // Location Name
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Location")
                            .font(.headline)
                        HStack {
                            CustomTextField(text: $location, placeholder: "Enter locations")
                        }
                    }
                    .padding()
                    

                    
                    // Salary Range
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Salary Range")
                            .font(.headline)
                        
                        HStack {
                            NumberTextField(placeholder: "Min range", value: $minSalary)
                            NumberTextField(placeholder: "Min range", value: $minSalary)
                        }
                    }
                    .padding()
                    
                    // Work Time
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Work Time")
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                workTimeIndex = 3
                            }) {
                                if workTimeIndex < 3 {
                                    Text("Clear")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        Picker(selection: $workTimeIndex, label: Text("")) {
                            ForEach(0 ..< 3) {
                                Text(self.workStyles[$0].rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    
                    // Work Style
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Work Style")
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                workStyleIndex = 3
                            }) {
                                if workStyleIndex < 3 {
                                    Text("Clear")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        Picker(selection: $workStyleIndex, label: Text("")) {
                            ForEach(0 ..< 3) {
                                Text(self.workStyles[$0].rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    
                    
                    // warefare
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Welfare")
                            .font(.headline)
                        Toggle("Bonus", isOn: $hasbonusFrequency)
                            .toggleStyle(CheckboxToggleStyle())
                        Toggle("Social security insurance", isOn: $hasSocialSecurity)
                            .toggleStyle(CheckboxToggleStyle())
                        Toggle("Provident fund", isOn: $hasProvidentFund)
                            .toggleStyle(CheckboxToggleStyle())
                        Toggle("Equipment fund", isOn: $hasEquipment)
                            .toggleStyle(CheckboxToggleStyle())
                           
                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {

            
            modelContext.insert(Job(
                company: self.companyName,
                department: self.departmentName,
                salaryRange: self.minSalary,
                location: self.location,
                workStyle: self.workStyleIndex < 3 ? self.workStyles[self.workStyleIndex] : nil,
                workTime: self.workTimeIndex < 2 ? self.workTimes[self.workTimeIndex] : nil,
                hasbonusFrequency: self.hasbonusFrequency,
                hasSocialSecurity: self.hasSocialSecurity,
                hasProvidentFund: self.hasProvidentFund,
                hasEquipment:  self.hasEquipment))
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
    }
}

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Spacer()
                    if !text.isEmpty {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 8)
                    }
                }
            )
    }
}

struct NumberTextField: View {
    
    @State private var text: String = ""
    var placeholder: String
    @Binding var value: String
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .keyboardType(.numberPad)
                .overlay(
                    HStack {
                        Spacer()
                        Text("B")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                )

        }
    }
}


struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 20.0) {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
            
        }
    }
}

#Preview {
    AddJobView()
}
