//
//  ShowJobList.swift
//  CareerCraft
//
//  Created by attaporn on 4/17/24.
//

import SwiftUI
import SwiftData


// Structure creating a custom textFieldStyle
struct WhiteBorder: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white, lineWidth:2)
            )
    }
}


struct ShowJobListView: View {
    
    @State private var username: String = ""
    @Environment(\.modelContext) private var modelContext
    @Query private var jobs: [Job]

    
    var body: some View {
        VStack(alignment: .center) {
        
            TextField("Search Company", text: $username)
                .textFieldStyle(.roundedBorder)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                .padding()
            
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(jobs) { item in
                            JobItemView(jobItem: item)
                        }
                        
                    }
                }
            

                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            addItem()
                        }) {
                            Image(systemName: "plus")
                                 .padding()
                                 .background(Color.blue)
                                 .foregroundColor(.white)
                                 .clipShape(Circle())
                                 .shadow(color: Color.black.opacity(0.3), radius: 3, x: 1, y: 1)
                        }
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                    }
                }
            }
        }
        .padding(.all, 20.0)
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Job(company: "Company A", department: "Engineering", salaryRange: "$50,000 - $70,000", location: "New York", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true)
            
            modelContext.insert(newItem)
            }
    }
    


}

#Preview {
    ShowJobListView()
}
