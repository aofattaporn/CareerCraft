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
    let workStyles: [WorkStyle] = [.onsite, .online, .hybrid]
    let workTimes: [WorkTime] = [.flexible, .fixed]
    
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
        case "salaryRange": return company.minSalary  ?? "-"
        case "location": return company.location ?? "-"
//        case "workStyleIndex": return company.workStyleIndex ? "" : "-"
//        case "workTimeIndex": return  workTimes[company.workTimeIndex].rawValue ?? "-"
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
