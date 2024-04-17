//
//  SelectCompany.swift
//  CareerCraft
//
//  Created by attaporn on 4/17/24.
//

import SwiftUI

//@Query private var items: [Job]
// Mocked items array
private var mockItems: [Job] = [
    Job(company: "Company A", department: "Engineering", salaryRange: "$50,000 - $70,000", location: "New York", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Company B", department: "Marketing", salaryRange: "$40,000 - $60,000", location: "San Francisco", workStyle: .hybrid, workTime: .flexible, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Company C", department: "Design", salaryRange: "$60,000 - $80,000", location: "Los Angeles", workStyle: .online, workTime: .flexible, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Company D", department: "Finance", salaryRange: "$70,000 - $90,000", location: "Chicago", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Company E", department: "Sales", salaryRange: "$50,000 - $70,000", location: "Seattle", workStyle: .hybrid, workTime: .flexible, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Company F", department: "Human Resources", salaryRange: "$45,000 - $65,000", location: "Boston", workStyle: .online, workTime: .flexible, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true)
]

struct SelectCompany: View {
    
    @State var text = ""
    
    var body: some View {
        
        VStack { // open-vstack
            
            VStack(alignment: .leading) {
                Text("Find Job for compare").font(.title3).bold()
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("Search...", text: $text)
                            }
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        }.padding()
            
            List { // open-list
                ForEach(mockItems) { item in
                    Text("Item at \(item.company)")
                }
            } // close-list
            
        } // close-vstack
       

    }
}

#Preview {
    SelectCompany()
}
