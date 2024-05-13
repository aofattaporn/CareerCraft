//
//  NumberTextField.swift
//  CareerCraft
//
//  Created by attaporn on 5/13/24.
//

import Foundation
import SwiftUI

struct NumberTextField: View {
    
    @Binding var text: String
    var placeholder: String

    
    var body: some View {
        HStack {
            
            TextField(placeholder, text: $text)
                .padding(10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .keyboardType(.numberPad)
                .onChange(of: text) {
                     if let intValue = Int(text) {
                         text = String(intValue)
                     } else {
                         text = ""
                     }
                 }
                 .overlay(
                    HStack {
                        Spacer()
                        Text("B")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                )

        }
    }
}
