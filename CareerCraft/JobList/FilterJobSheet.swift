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

    
    @Query var jobItem: [Job]
    @Binding var workStyleIndex: Int
    @Binding var workTimeIndex: Int
    @Binding var minSalary: String
    @Binding var maxSalary: String

    
    @Binding var isFilter: Bool
    
    @State private var filteredJobs: [Job] = []
    
    private func resetFilter() {
        self.workTimeIndex = -1
        self.workStyleIndex = -1
        self.minSalary = ""
        self.maxSalary = ""
    }

    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {

            
            HStack{
                Spacer()
                Button(action: {
                    isFilter = false
                    resetFilter()
                }) {
                    Text("Reset")
                        .font(.headline)
                        .foregroundColor(
                            workStyleIndex == -1 &&
                            workTimeIndex == -1 &&
                            minSalary == "" &&
                            maxSalary == ""
                            ? Color.gray : Color.blue
                        )
                        .disabled(
                            workStyleIndex == -1 &&
                            workTimeIndex == -1 &&
                            minSalary == "" &&
                            maxSalary == ""
                        )
                }
            }
            .padding()
            .padding(.top, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    
                    // **** Salary Range ****
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Salary Range")
                            .font(.headline)
                        
                        HStack {
                            HStack {
                                
                                TextField("Min", text: $minSalary)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .keyboardType(.numberPad)
                                    .onChange(of: minSalary) {
                                         if let intValue = Int(minSalary) {
                                             minSalary = String(intValue)
                                         } else {
                                             minSalary = ""
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
                                
                                TextField("Min", text: $maxSalary)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .keyboardType(.numberPad)
                                    .onChange(of: maxSalary) {
                                         if let intValue = Int(maxSalary) {
                                             maxSalary = String(intValue)
                                         } else {
                                             maxSalary = ""
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
                                workTimeIndex = -1
                            }) {
                                if workTimeIndex != -1 {
                                    Text("Clear")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        Picker(selection: $workTimeIndex, label: Text("")) {
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
                                workStyleIndex = -1
                            }) {
                                if workStyleIndex != -1 {
                                    Text("Clear")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        Picker(selection: $workStyleIndex, label: Text("")) {
                            ForEach(0 ..< Constants.Job.WorkStyle.count, id: \.self) {
                                Text(Constants.Job.WorkStyle[$0].rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                }
            }
        }
        
        Spacer()
        
        HStack {
            Button(action: {
                isFilter = true
                dismiss()
            }) {
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
