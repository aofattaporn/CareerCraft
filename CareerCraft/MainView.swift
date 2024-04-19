//
//  ContentView.swift
//  CareerCraft
//
//  Created by attaporn on 4/17/24.
//

import SwiftUI
import SwiftData

enum Tabs {
    case ShowJobListView
    case CompareJobView
}

struct MainView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var jobs: [Job]
    
    @State var selectedTab = Tabs.ShowJobListView
    @State var isListJobView: Bool = true
    @State var isCompareJob: Bool = false
    
    @State private var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    //@Query private var items: [Job]
    private var mockItems: [Job] = [
        Job(company: "Company A", department: "Engineering", salaryRange: "$50,000 - $70,000", location: "New York", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
        Job(company: "Company B", department: "Marketing", salaryRange: "$40,000 - $60,000", location: "San Francisco", workStyle: .hybrid, workTime: .flexible, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
        Job(company: "Company C", department: "Design", salaryRange: "$60,000 - $80,000", location: "Los Angeles", workStyle: .online, workTime: .flexible, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
        Job(company: "Company D", department: "Finance", salaryRange: "$70,000 - $90,000", location: "Chicago", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
        Job(company: "Company E", department: "Sales", salaryRange: "$50,000 - $70,000", location: "Seattle", workStyle: .hybrid, workTime: .flexible, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true),
        Job(company: "Company F", department: "Human Resources", salaryRange: "$45,000 - $65,000", location: "Boston", workStyle: .online, workTime: .flexible, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true)
    ]
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    private func deleteItem(at offsets: IndexSet) {
      items.remove(atOffsets: offsets)
    }


    var body: some View {
             
        NavigationView{ // open-navigation
            
            VStack { // open-vstack

                ZStack { // open-zstack
                    
                    // *** background-canvas  ***
                    VStack(alignment: .leading) { // open-vstack-2
                        
                        Text("Find your Job ")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                        
                        Text(dateFormatter.string(from: Date()))
                            .font(.caption)
                            .foregroundColor(.white)
                        
                    } // close-open-vstack-2
                    .padding()
                    .padding(.bottom, 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color("secondary"), Color("primary")]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(10)
                    .padding(.all)
      
                    
                    // *** tab-item-view  ***
                    HStack() { // open-hstack
                        Text("List Job")
                            .frame(width: 150)
                            .padding(.vertical)
                            .background(isListJobView  ? Color("primary") : Color("bg-grey"))
                            .foregroundColor(isListJobView  ? .white : Color("primary"))
                            .cornerRadius(5)
                            .onTapGesture {
                                self.selectedTab = .ShowJobListView
                                self.isCompareJob = false
                                self.isListJobView = true
                            }
                        Text("Compare Job")
                            .frame(width: 150)
                            .padding(.vertical)
                            .background(isCompareJob  ? Color("primary") : Color("bg-grey"))
                            .foregroundColor(isCompareJob  ? .white : Color("primary"))
                            .cornerRadius(5)
                            .onTapGesture {
                                self.selectedTab = .CompareJobView
                                self.isListJobView = false
                                self.isCompareJob = true
                            }
                    } // close-hstack
                    .padding(.all)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
                    .offset(y: 55)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                    
                } // close-zstck
                
                // View from taping ***
                VStack { // open-vstack
                    switch selectedTab {
                        case .ShowJobListView:  ShowJobListView()
                        case .CompareJobView:  CompareJobView()
                    }
                } // close-vstack
                .padding(.all)
                

                

                Spacer()
                
            } // close-vstack
            
            
 
        } // close-navigation
    }
}

#Preview {
    MainView()
        .modelContainer(for: Job.self, inMemory: true)
}
