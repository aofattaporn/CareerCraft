//
//  CompareJobView.swift
//  CareerCraft
//
//  Created by attaporn on 4/17/24.
//

import SwiftUI

struct CompareJobView: View {
    var body: some View {
        VStack(spacing: 50){ // open-vstack
            
            // *** select label ***
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(0..<10) {
                        Button("Item \($0)"){}
                            .foregroundStyle(.white)
                            .font(.headline)
                            .frame(width: 100)
                            .background(Color("secondary"))
                            .cornerRadius(10)
                    }
                }
            }
            
            // *** show compare ***
            HStack {
                
                // *** company-1 ***
                VStack {
                    
                    Button("Company 1"){
                        
                    }
                    
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color("primary"))
                .foregroundColor(.white)
                .cornerRadius(10)


                
                // *** company-2 ***
                VStack {
                    
                    Button("Company 2"){
                        
                    }
                    
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color("primary"))
                .foregroundColor(.white)
                .cornerRadius(10)


                
            }
            
        } // close-vstack
    }
}

#Preview {
    CompareJobView()
}
