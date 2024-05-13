//
//  JobItemView.swift
//  CareerCraft
//
//  Created by attaporn on 4/18/24.
//

import SwiftUI
import PhotosUI

struct JobItemView: View {
    
    var jobItem : Job
    @State var selectedPhotoData: Data?
    
    var body: some View {
        HStack { // open-hstack-1
            
            // *** Left section ***

            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 150)
                .overlay(
                    Group {
                        if let selectedPhotoData = jobItem.imageData,
                           let uiImage = UIImage(data: selectedPhotoData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 32, height: 32)
                                .padding(20)
                        }
                    }
                )


            // *** Right section ***
            HStack {
                VStack(alignment: .leading) { // open-vstack
                    
                    Text("\(self.jobItem.company)")
                        .bold()
                        .font(.body)
                    Text("\(self.jobItem.department)")
                        .font(.callout)
                        .foregroundColor(Color("primary-app"))
                    Spacer()
                    HStack{
                        if(self.jobItem.appliedState == .notApplied){
                            Image(systemName: "circle")
                                .foregroundStyle(.black)
                            Text("Not Applied")
                                .font(.callout)
                                .foregroundStyle(.black)
                        } else if (self.jobItem.appliedState == .applied) {
                            Image(systemName: "checkmark.circle")
                                .foregroundStyle(.yellow)
                            Text("Applied")
                                .font(.callout)
                                .foregroundStyle(.yellow)
                        } else {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                            Text("Passed")
                                .font(.callout)
                                .foregroundStyle(.green)
                        }
                    }
                } // close-vstack
                .padding()
                .background(Color.white)
                

                Spacer(minLength: 18)
                
            }
            
        }  // close-hstack-1
//        .frame(minHeight: 120)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("bg-grey"), lineWidth: 3)
        )
        .cornerRadius(10)
        .accessibility(label: Text("\(jobItem.company), \(jobItem.department)"))

        
        
    }
        
        
    
}
