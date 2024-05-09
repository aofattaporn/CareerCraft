//
//  FilterJobSheet.swift
//  CareerCraft
//
//  Created by attaporn on 4/19/24.
//

import SwiftUI

struct FilterJobSheet: View {
    
    
    let workStyles:[WorkStyle] = [.onsite, .online, .hybrid]
    let workTimes:[WorkTime]  = [.flexible, .fixed]
    
    @Binding  var filterMinSalary: String
    @Binding  var filterMaxSalary: String
    @Binding  var workStyleIndex: Int
    @Binding  var workTimeIndex: Int
    @Binding  var filterHasbonusFrequency: Bool
    @Binding  var filterHasSocialSecurity: Bool
    @Binding  var filterHasProvidentFund: Bool
    @Binding  var filterHasEquipment: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            
            HStack{
                Spacer()
                Button(action: {
                    resetFilter()
                }) {
                    Text("Reset")
                        .font(.headline)
                        .foregroundColor(
                            filterMinSalary.isEmpty &&
                            filterMaxSalary.isEmpty &&
                            workStyleIndex == 3 &&
                            workTimeIndex == 3
                            ? Color.gray : Color.blue
                        )
                        .disabled(
                            filterMinSalary.isEmpty &&
                            filterMaxSalary.isEmpty &&
                            workStyleIndex == 3 &&
                            workTimeIndex == 3
                        )
                }



            }
            .padding()
            .padding(.top, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Salary Range")
                            .font(.headline)
                        
                        HStack {
                            HStack {
                                TextField( "Min range", text: $filterMinSalary)
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
                            HStack {
                                TextField( "Min range", text: $filterMaxSalary)
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
                    
                    // Welfare
//                    VStack(alignment: .leading, spacing: 20) {
//                        Text("Welfare")
//                            .font(.headline)
//                        Toggle("Bonus", isOn: $filterHasbonusFrequency)
//                            .toggleStyle(CheckboxToggleStyle())
//                        Toggle("Social security insurance", isOn: $filterHasSocialSecurity)
//                            .toggleStyle(CheckboxToggleStyle())
//                        Toggle("Provident fund", isOn: $filterHasProvidentFund)
//                            .toggleStyle(CheckboxToggleStyle())
//                        Toggle("Equipment fund", isOn: $filterHasEquipment)
//                            .toggleStyle(CheckboxToggleStyle())
//                    }
//                    .padding()
                    
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
    
    
    private func resetFilter() {
        self.filterMinSalary = ""
        self.filterMaxSalary = ""
        self.workTimeIndex = 3
        self.workStyleIndex = 3
        self.filterHasbonusFrequency = false
        self.filterHasSocialSecurity = false
        self.filterHasProvidentFund = false
        self.filterHasEquipment = false
    }
}


//#Preview {
//
//    FilterJobSheet(
//        filterMinSalary: Binding<"">, filterMaxSalary: <#T##Binding<String>#>, workStyleIndex: <#T##Binding<Int>#>, workTimeIndex: <#T##Binding<Int>#>, filterHasbonusFrequency: <#T##Binding<Bool>#>, filterHasSocialSecurity: <#T##Binding<Bool>#>, filterHasProvidentFund: <#T##Binding<Bool>#>, filterHasEquipment: <#T##Binding<Bool>#>
//
//
////        filterMinSalary: "",
////        filterMaxSalary: "",
////        workStyleIndex: 0,
////        workTimeIndex: 0,
////        filterHasbonusFrequency: false,
////        filterHasSocialSecurity: false,
////        filterHasProvidentFund: false,
////        filterHasEquipment: false
//    
//    )
//}
