//
//  FilterJobSheet.swift
//  CareerCraft
//
//  Created by attaporn on 4/19/24.
//

import SwiftUI
import SwiftData

struct FilterJobSheet: View {
    
    @Environment(\.dismiss) var dismiss

    @Binding var filterWorkStyleIndex: Int
    @Binding var filterWorkTimeIndex: Int
    @Binding var filterMinSalary: String
    @Binding var filterMaxSalary: String
    
    @State var tempWorkStyleIndex: Int = -1
    @State var tempWorkTimeIndex: Int = -1
    @State var tempMinSalary: String = ""
    @State var tempMaxSalary: String = ""
            
    private func resetFilter() {
        self.tempWorkStyleIndex = -1
        self.tempWorkTimeIndex = -1
        self.tempMinSalary = ""
        self.tempMaxSalary = ""
    }
    
    private func applyFilter() {
        filterWorkStyleIndex = tempWorkStyleIndex
        filterWorkTimeIndex = tempWorkTimeIndex
        filterMinSalary = tempMinSalary
        filterMaxSalary = tempMaxSalary
    }
    
    private func checkFilterDirty() ->Bool {
        if (
            filterWorkStyleIndex != tempWorkStyleIndex ||
            filterWorkTimeIndex != tempWorkTimeIndex ||
            filterMinSalary != tempMinSalary ||
            filterMaxSalary != tempMaxSalary
        ) {
            return true
        } else {
            return false
        }
    }
    
    

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            
            HStack{
                Spacer()
                Button(action: {
                    resetFilter()
                }) {
                    Text("Reset")
                        .font(.headline)
                }
            }
            .padding()
            .padding(.top, 20)
            
            ScrollView { // open-scrollview
                
                VStack(alignment: .leading, spacing: 0.0) { // open-view
                    
                    // **** Salary Range ****
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Salary Range")
                            .font(.headline)
                        
                        HStack {
                            HStack {
                                
                                TextField("Min", text: $tempMinSalary)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .keyboardType(.numberPad)
                                    .onChange(of: tempMinSalary) {
                                         if let intValue = Int(tempMinSalary) {
                                             tempMinSalary = String(intValue)
                                         } else {
                                             tempMinSalary = ""
                                         }
                                     }
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
                                
                                TextField("Max", text: $tempMaxSalary)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .keyboardType(.numberPad)
                                    .onChange(of: tempMaxSalary) {
                                         if let intValue = Int(tempMaxSalary) {
                                             tempMaxSalary = String(intValue)
                                         } else {
                                             tempMaxSalary = ""
                                         }
                                     }
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
                                tempWorkTimeIndex = -1
                            }) {
                                if tempWorkTimeIndex != -1 {
                                    Text("Clear")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        Picker(selection: $tempWorkTimeIndex, label: Text("")) {
                            ForEach(0 ..< Constants.Job.workTimes.count, id: \.self) {
                                Text(Constants.Job.workTimes[$0].rawValue)
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
                                tempWorkStyleIndex = -1
                            }) {
                                if tempWorkStyleIndex != -1 {
                                    Text("Clear")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        Picker(selection: $tempWorkStyleIndex, label: Text("")) {
                            ForEach(0 ..< Constants.Job.WorkStyle.count, id: \.self) {
                                Text(Constants.Job.WorkStyle[$0].rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    
                }
            }
        }.onAppear{
            tempWorkTimeIndex = filterWorkTimeIndex
            tempWorkStyleIndex = filterWorkStyleIndex
            tempMaxSalary = filterMaxSalary
            tempMinSalary = filterMinSalary
        }
        
        Spacer()
        
        HStack {
            Button(action: {
                applyFilter()
                dismiss()
            }) {
                Text("Apply")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.red).opacity(!checkFilterDirty() ? 0.5 : 1)
                    .foregroundColor(.white)
                    
            }
            .disabled(!checkFilterDirty())
            .cornerRadius(10)
            .padding()
        }
        
    }
}

struct NumberTextField2: View {
    
    @Binding var text: String
    var placeholder: String

    
    var body: some View {
        HStack {
            
            TextField(placeholder, text: $text)
                .padding(10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .keyboardType(.numberPad)
                .onChange(of: text) {
                     if let intValue = Int(text) {
                         text = String(intValue)
                     } else {
                         text = ""
                     }
                 }
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
