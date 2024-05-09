//
//  JobItemView.swift
//  CareerCraft
//
//  Created by attaporn on 4/18/24.
//

import SwiftUI

struct JobItemView: View {
    
    var jobItem : Job
    
    var body: some View {
        HStack { // open-hstack-1
            
            // *** Left section ***
            Rectangle()
                .fill(Color("bg-grey"))
            
            // *** Right section ***
            HStack {
                VStack(alignment: .leading) { // open-vstack
                    
                    Text("\(self.jobItem.company)")
                        .bold()
                        .font(.body)
                    Text("\(self.jobItem.department!)")
                        .font(.callout)
                        .foregroundColor(Color("primary"))
                    Spacer()
                } // close-vstack
                .padding(.vertical)
                
                Spacer(minLength: 18)
            }
            
        }  // close-hstack-1
        .frame(minHeight: 120)
        .background(Color.white)
        .border(Color("bg-grey"))
        .cornerRadius(10)
        .accessibility(label: Text("\(jobItem.company), \(jobItem.department ?? "")")) 
        
        
    }
        
    
}
    

//#Preview {
//    JobItemView(jobItem: Job(company: "Tech Solutions Inc.", department: "Engineering", salaryRange: "$50,000 - $70,000", location: "New York", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true))
//}
