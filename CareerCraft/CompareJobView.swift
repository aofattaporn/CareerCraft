//
//  CompareJobView.swift
//  CareerCraft
//
//  Created by attaporn on 4/17/24.
//

import SwiftUI

struct CompareJobView: View {
    
    @State private var showSelectLabels = false
    
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
                    NavigationLink(destination: SelectCompany()){
                        VStack {
                            Text("Company 1")
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("primary"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
  
                    
                    
                    // *** company-2 ***
                    // *** company-1 ***
                    NavigationLink(destination: SelectCompany()){
                        VStack {
                            Text("Company 2")
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("primary"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }

                    
                }
                
                Spacer()
                
            } // close-vstack
            
        
    }
}

#Preview {
    CompareJobView()
}
