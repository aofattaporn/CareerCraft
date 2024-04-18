//
//  JobItemView.swift
//  CareerCraft
//
//  Created by attaporn on 4/18/24.
//

import SwiftUI

private var mockItems: [Job] = [
    Job(company: "Company A", department: "Engineering", salaryRange: "$50,000 - $70,000", location: "New York", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Company B", department: "Marketing", salaryRange: "$40,000 - $60,000", location: "San Francisco", workStyle: .hybrid, workTime: .flexible, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Company C", department: "Design", salaryRange: "$60,000 - $80,000", location: "Los Angeles", workStyle: .online, workTime: .flexible, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Company D", department: "Finance", salaryRange: "$70,000 - $90,000", location: "Chicago", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Company E", department: "Sales", salaryRange: "$50,000 - $70,000", location: "Seattle", workStyle: .hybrid, workTime: .flexible, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Company F", department: "Human Resources", salaryRange: "$45,000 - $65,000", location: "Boston", workStyle: .online, workTime: .flexible, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true)
]


struct JobItemView: View {
    
    var jobItem : Job
    
    var body: some View {
        HStack {
            // Left section
            Rectangle()
                .fill(Color("bg-grey"))
                .frame(height: 100)
                .cornerRadius(10)
            
            // Spacer to push the next section to the right
            Spacer()
            
            // Right section
            VStack(alignment: .leading) {
                Text("\(self.jobItem.company)")
                    .bold()
                    .font(.title2)
                Text("\(self.jobItem.department!)")
                    .font(.callout)
                    .foregroundColor(Color("primary"))
                Spacer()
            }
            .cornerRadius(10)
            .padding(.horizontal, 10)
        }
        .background(Color.white) // Add background color to ensure shadow is visible
//        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2) 
        .padding(.all)
        .border(Color("bg-grey"))

        
    }
    
    
}

#Preview {
    JobItemView(jobItem: mockItems[0])
}
