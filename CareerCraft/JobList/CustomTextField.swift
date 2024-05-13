//
//  CustomTextField.swift
//  CareerCraft
//
//  Created by attaporn on 5/13/24.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Spacer()
                    if !text.isEmpty {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 8)
                    }
                }
            )
    }
}
