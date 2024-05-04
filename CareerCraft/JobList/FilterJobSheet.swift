//
//  FilterJobSheet.swift
//  CareerCraft
//
//  Created by attaporn on 4/19/24.
//

import SwiftUI

struct FilterJobSheet: View {
    
    
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
        VStack(alignment: .leading, spacing: 0.0) {
            
            HStack{
                Spacer()
                Text("Reset")
                    .font(.headline)
            }
            .padding()
            .padding(.top, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    
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
                    
                    
                }
            }
            

            
            
            
        }
        
        Spacer()
        
        
        HStack {
            Button(action: {}) {
                Text("Apply")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                   
            }
            .cornerRadius(10)
            .padding()
            
        }
    
        
        
        
        
    
    }
        
}

#Preview {
    FilterJobSheet()
}
