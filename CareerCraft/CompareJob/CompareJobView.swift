//
//  CompareJobView.swift
//  CareerCraft
//
//  Created by attaporn on 4/17/24.
//

import SwiftUI

struct CompareJobView: View {
    
    @State private var showSelectLabels = false
    
    @State var company1: Job?
    @State var company2: Job?
    @State private var selectorNum1: Int = 1
    @State private var selectorNum2: Int = 2
    
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
                            SelectLabels()
                                .presentationDetents([.fraction(0.25), .fraction(0.75)])
                               
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)


                
                // *** show compare ***
                HStack {
                    
                    // *** company-1 ***
                    NavigationLink(destination: SelectCompany(
                        company1: $company1,
                        company2: $company2,
                        selectorNum: $selectorNum1
                    )){
                        VStack {
                            Text(company1 != nil ? company1!.company : "-")
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
                            Text(company2 != nil ? company2!.company : "-")
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(company2 != nil ? Color("secondary") : Color("bg-grey"))
                        .foregroundColor(company2 != nil ? .white : .gray)
                        .cornerRadius(10)
                    }

                    
                }
                
                Spacer()
                
            } // close-vstack
            
        
    }
}

#Preview {
    CompareJobView( )
}
