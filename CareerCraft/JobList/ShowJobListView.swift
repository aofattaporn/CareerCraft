//
//  ShowJobList.swift
//  CareerCraft
//
//  Created by attaporn on 4/17/24.
//

import SwiftUI
import SwiftData


// Structure creating a custom textFieldStyle
struct WhiteBorder: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white, lineWidth:2)
            )
    }
}


private var mockItems: [Job] = [
    Job(company: "Tech Solutions Inc.", department: "Engineering", salaryRange: "$50,000 - $70,000", location: "New York", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Marketing Innovations Co.", department: "Marketing", salaryRange: "$40,000 - $60,000", location: "San Francisco", workStyle: .hybrid, workTime: .flexible, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "DesignWorks Studio", department: "Design", salaryRange: "$60,000 - $80,000", location: "Los Angeles", workStyle: .online, workTime: .flexible, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Financial Services LLC", department: "Finance", salaryRange: "$70,000 - $90,000", location: "Chicago", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Sales Solutions Group", department: "Sales", salaryRange: "$50,000 - $70,000", location: "Seattle", workStyle: .hybrid, workTime: .flexible, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
    Job(company: "Human Capital Partners", department: "Human Resources", salaryRange: "$45,000 - $65,000", location: "Boston", workStyle: .online, workTime: .flexible, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true)
]

struct ShowJobListView: View {
    
    
    @Environment(\.modelContext) private var modelContext
    @Query private var jobs: [Job]
    
    @State private var username: String = ""
    @State private var showFilterJobSheet = false
    
    @State private var showDeleteSheet = false
    @State private var selectedItem: Job?
    
    @State var showAlert = false


    var body: some View {
        VStack(alignment: .center) { // open-vstack
        
            // *** textField-for-searching ***
            TextField("Search Company", text: $username)
                .padding(.vertical, 10)
                .padding(.horizontal, 24)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                .padding(.top)
            
            // *** filter-for-searching ***
            HStack { // open-hstack
                Spacer()
                Button(action: {
                    self.showFilterJobSheet.toggle()
                }) { // open-filtern-btn
                    Image(systemName: "slider.horizontal.3")
                         .padding()
                         .foregroundColor(Color("secondary"))
                         .font(.system(size: 24))
                } // close-filtern-btn
                .sheet(isPresented: $showFilterJobSheet) {
                    if #available(iOS 16.0, *) {
                        FilterJobSheet()
                            .presentationDetents([.fraction(0.25)])
                    
                    }
                }
            } // close-hstack
            
            // *** background-canvas ***
            ZStack { // open-ztack
                
                ScrollView([.vertical]){ // open-scrollview-1
                    VStack {
                        ForEach(jobs) { item in
                                JobItemView(jobItem: item)
                                .onTapGesture {}
                                .onLongPressGesture {
                                    self.showAlert.toggle()
                                    self.selectedItem = item
                                }
                                .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("Just a moment"),
                                        message: Text("Are you sure you want to delete this item?"),
                                        primaryButton: .cancel(Text("Cancel")),
                                        secondaryButton: .destructive(Text("OK")) {
                                            deleteItems(job: self.selectedItem!)
                                        }
                                    )
                                }
                        }
                    }
                } // close-scrollview-1
                .defaultScrollAnchor(.top)

                VStack { // open-vstack-3 [floatting-button]
                    
                    Spacer()
                    HStack { // open-hstack
                        Spacer()
                        Button(action: {
                            addItem()
                        }) { // open-flotting-btn
                            Image(systemName: "plus")
                                 .padding()
                                 .background(Color("primary"))
                                 .foregroundColor(.white)
                                 .clipShape(Circle())
                                 .shadow(color: Color.black.opacity(0.3), radius: 3, x: 1, y: 1)
                        } // close-flotting-btn
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                    } // close-hstack
                    
                } // close-vstack-3
            }
        }
        
    } // close-vstack
    
    // function-add-job
    private func addItem() {
        withAnimation {
            let randomIndex = Int.random(in: 0..<mockItems.count)
            let randomItem = mockItems[randomIndex]
            
            modelContext.insert(randomItem)
            }
    }
    
    // function-remove-job
    private func deleteItems(job: Job) {
        withAnimation {
            modelContext.delete(job)
//            for index in offsets {
//                let jobToDelete = jobs[index]
//                modelContext.delete(jobToDelete)
//            }
        }
    }

}

#Preview {
    ShowJobListView()
}
