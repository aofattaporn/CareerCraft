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
    
    // attributes: controllers tab views
    @State var selectedTab = Tabs.ShowJobListView
    @State var isListJobView: Bool = true
    @State var isCompareJob: Bool = false
    
    // method: date format 
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
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
                        LinearGradient(gradient: Gradient(colors: [Color("secondary-app"), Color("primary-app")]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(10)
                    .padding(.all)
      
                    
                    // *** tab-item-view  ***
                    HStack() { // open-hstack
                        Text("List Job")
                            .frame(width: 150)
                            .padding(.vertical)
                            .background(isListJobView  ? Color("primary-app") : Color("bg-grey"))
                            .foregroundColor(isListJobView  ? .white : Color("primary-app"))
                            .cornerRadius(5)
                            .onTapGesture {
                                self.selectedTab = .ShowJobListView
                                self.isCompareJob = false
                                self.isListJobView = true
                            }
                        Text("Compare Job")
                            .frame(width: 150)
                            .padding(.vertical)
                            .background(isCompareJob  ? Color("primary-app") : Color("bg-grey"))
                            .foregroundColor(isCompareJob  ? .white : Color("primary-app"))
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
