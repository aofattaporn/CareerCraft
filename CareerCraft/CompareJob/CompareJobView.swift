//
//  CompareJobView.swift
//  CareerCraft
//
//  Created by attaporn on 4/17/24.
//

import SwiftUI
import SwiftData


struct CompareJobView: View {
    

    @State private var showSelectLabels = false
    
    @State var company1: Job?
    @State var company2: Job?
    
    @State private var selectorNum1: Int = 1
    @State private var selectorNum2: Int = 2
    
    @Query private var jobs: [Job]
    @State private var jobTypeKeys: [String] = [
        "department",
        "salaryRange",
        "location",
        "workStyleIndex",
        "workTimeIndex",
        "hasbonusFrequency",
        "hasSocialSecurity",
        "hasProvidentFund",
        "hasEquipment"
    ]
    @State private var filterJobTypeKeys: [String] = [
        "department",
        "salaryRange",
        "location",
        "workStyleIndex",
        "workTimeIndex",
        "hasbonusFrequency",
        "hasSocialSecurity",
        "hasProvidentFund",
        "hasEquipment"
    ]


    
    func value(forKey key: String, company: Job?) -> String {
        guard let company = company else {
            return "-"
        }
        switch key {
        case "company": return company.company
        case "department": return company.department
        case "salaryRange":
            if (company.minSalary != nil &&  company.maxSalary != nil) {
                let max = String(company.maxSalary ?? 0)
                let min = String(company.minSalary ?? 0)
                return "\(min) - \(max)"
            } 
            
            else if (company.maxSalary != nil) {
                let max = String(company.maxSalary ?? 0)
                return "(max) \(max)"
            } 
            
            else if (company.minSalary != nil) {
                let min = String(company.minSalary ?? 0)
                return "(min) \(min)"
            } 
            
            else {
                return "-"
            }
        case "location": return company.location ?? "-"
        case "workTimeIndex":
            if(company.workTime.rawValue == "unknown") { return "-" }
            return company.workTime.rawValue
        case "workStyleIndex": 
            if(company.workStyle.rawValue == "unknown") { return "-" }
            return company.workStyle.rawValue
        case "hasbonusFrequency": return company.hasbonusFrequency ? "Bonus" : "No Bonus"
        case "hasSocialSecurity": return company.hasSocialSecurity ? "SocialSecurity" : "No SocialSecurity"
        case "hasProvidentFund": return company.hasProvidentFund ? "ProvidentFund" : "No ProvidentFund"
        case "hasEquipment": return company.hasEquipment ? "Equipment" : "No Equipment"
        default: return "-"
        }
    }


    var body: some View {
        
            VStack(spacing: 12){ // open-vstack
                
                // *** select label ***
                HStack(alignment: .bottom) {
                    Spacer() // This will push the content to the trailing edge
                    Button(action: {self.showSelectLabels.toggle()})
                    {
                        Text("Select Labels")
                            .padding(.all)
                            .cornerRadius(10)
                            .foregroundColor(Color("secondary-app"))
                    }.sheet(isPresented: $showSelectLabels) {
                        if #available(iOS 16.0, *) {
                            SelectLabels(
                                jobTypeKeys: self.$jobTypeKeys,
                                filterJobTypeKeys: self.$filterJobTypeKeys)
                                .presentationDetents([.fraction(0.25), .fraction(0.75)])
                               
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)


                
                // *** show compare ***
                VStack {
                    HStack {
                        
                        // *** company-1 ***
                        NavigationLink(destination: SelectCompany(
                            company1: $company1,
                            company2: $company2,
                            selectorNum: $selectorNum1
                        )){
                            VStack {
                                Text(company1?.company ?? "-")
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(company1 != nil ? Color("secondary-app") : Color("bg-grey"))
                            .foregroundColor(company1 != nil ? .white : .gray)
                            .cornerRadius(10)
                        }
      
                        
                        
                        // *** company-2 ***
                        NavigationLink(destination: SelectCompany(
                            company1: $company1,
                            company2: $company2,
                            selectorNum: $selectorNum2
                        )){
                            VStack {
                                Text(company2?.company ?? "-")
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(company1 != nil ? Color("secondary-app") : Color("bg-grey"))
                            .foregroundColor(company1 != nil ? .white : .gray)
                            .cornerRadius(10)
                        }

                    }
                    
                    
                    
                    ScrollView([.vertical]) {
                        VStack(alignment: .center) {
                            
                            if (company1 != nil)  || (company2 != nil)  {
                                ForEach(Array(filterJobTypeKeys.enumerated()), id: \.element) { index, key in
                                    HStack {
                                        VStack {
                                            Spacer()
                                            Text(self.value(forKey: key, company: self.company1))
                                            Spacer()
                                        }
                                        .frame(maxWidth: .infinity)
                                        .background(index.isMultiple(of: 2) ? Color("bg-grey") : Color.white) // Alternating row colors
                                        
                                        VStack {
                                            Spacer()
                                            Text(self.value(forKey: key, company: self.company2))
                                            Spacer()
                                        }
                                        .frame(maxWidth: .infinity)
                                        .background(index.isMultiple(of: 2) ? Color("bg-grey") : Color.white) // Alternating row colors
                                    }
                                }
                            }
 
                        }
                    }
                    .defaultScrollAnchor(.top)



                } // close-vstack
                
                Spacer()
                
            } // close-vstack
            
        
    }
}

#Preview {
    CompareJobView( )
}
