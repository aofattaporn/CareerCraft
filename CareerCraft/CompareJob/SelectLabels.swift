//
//  SelectLabels.swift
//  CareerCraft
//
//  Created by attaporn on 4/18/24.
//

import SwiftUI
import SwiftData


struct SelectLabels: View {
    
    @Binding var jobTypeKeys: [String]
    @Binding var filterJobTypeKeys: [String]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .padding(.all)
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.jobTypeKeys, id: \.self) { platform in
                self.item(for: platform)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if platform == self.jobTypeKeys.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if platform == self.jobTypeKeys.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }

    func item(for text: String) -> some View {
        Button(action: {
            // Toggle filter
            if let index = filterJobTypeKeys.firstIndex(of: text) {
                filterJobTypeKeys.remove(at: index)
            } else {
                filterJobTypeKeys.append(text)
            }
        }, label: {
            Text(text)
                .padding(.all, 5)
                .font(.body)
                .background(filterJobTypeKeys.contains(text) ? Color("secondary") : Color("bg-grey"))
                .foregroundColor(filterJobTypeKeys.contains(text) ? .white : .gray)
                .cornerRadius(5)
        })
    }
}





#Preview {
    SelectLabels(jobTypeKeys: .constant([
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
    ]),
    
    filterJobTypeKeys: .constant([
        "company",
        "department",
        "salaryRange",
        "location",
        "workStyle",
        "workTime",
        "hasbonusFrequency",
        "hasSocialSecurity"
    ]))
}
