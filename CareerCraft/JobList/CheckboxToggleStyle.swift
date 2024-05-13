//
//  CheckboxToggleStyle.swift
//  CareerCraft
//
//  Created by attaporn on 5/13/24.
//

import SwiftUI
import Foundation

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 20.0) {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
            
        }
    }
}
