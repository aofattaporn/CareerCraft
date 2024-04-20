//
//  CompareJobView.swift
//  CareerCraft
//
//  Created by attaporn on 4/17/24.
//

import SwiftUI
import SwiftData

private var mockItems: [Job] = [
    Job(company: "Tech Solutions Inc.", department: "Engineering", salaryRange: "$50,000 - $70,000", location: "New York", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Marketing Innovations Co.", department: "Marketing", salaryRange: "$40,000 - $60,000", location: "San Francisco", workStyle: .hybrid, workTime: .flexible, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "DesignWorks Studio", department: "Design", salaryRange: "$60,000 - $80,000", location: "Los Angeles", workStyle: .online, workTime: .flexible, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Financial Services LLC", department: "Finance", salaryRange: "$70,000 - $90,000", location: "Chicago", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Sales Solutions Group", department: "Sales", salaryRange: "$50,000 - $70,000", location: "Seattle", workStyle: .hybrid, workTime: .flexible, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Human Capital Partners", department: "Human Resources", salaryRange: "$45,000 - $65,000", location: "Boston", workStyle: .online, workTime: .flexible, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true)
]

struct CompareJobView: View {
    

    @State private var showSelectLabels = false
    
    @State var company1: Job?
    @State var company2: Job?
    
    @State private var selectorNum1: Int = 1
    @State private var selectorNum2: Int = 2
    
    @Query private var jobs: [Job]
    @State private var jobTypeKeys: [String] = [
        "company",
        "department",
        "salaryRange",
        "location",
        "workStyle",
        "workTime",
        "hasbonusFrequency",
        "hasSocialSecurity",
        "hasProvidentFund",
        "hasEquipment"
    ]
    @State private var filterJobTypeKeys: [String] = [
        "company",
        "department",
        "salaryRange",
        "location",
        "workStyle",
        "workTime",
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
        case "department": return company.department ?? "-"
        case "salaryRange": return company.salaryRange ?? "-"
        case "location": return company.location ?? "-"
        case "workStyle": return company.workStyle.rawValue
        case "workTime": return company.workTime.rawValue
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
                            .foregroundColor(Color("secondary"))
                    }.sheet(isPresented: $showSelectLabels) {
                        if #available(iOS 16.0, *) {
                            SelectLabels(jobTypeKeys: self.$jobTypeKeys, filterJobTypeKeys: self.$filterJobTypeKeys)
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
                            .background(company1 != nil ? Color("secondary") : Color("bg-grey"))
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
                            .background(company1 != nil ? Color("secondary") : Color("bg-grey"))
                            .foregroundColor(company1 != nil ? .white : .gray)
                            .cornerRadius(10)
                        }

                    }
                    
                    
                    ScrollView([.vertical]) {
                        VStack(alignment: .center) {
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
                    .defaultScrollAnchor(.top)



                } // close-vstack
                
                Spacer()
                
            } // close-vstack
            
        
    }
}

#Preview {
    CompareJobView( )
}
