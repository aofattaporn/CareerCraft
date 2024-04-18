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


struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State var selectedTab = Tabs.ShowJobListView
    @State var isListJobView: Bool = true
    @State var isCompareJob: Bool = false
    
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
                    
                    // *** tab-content-view  ***
                    
                    VStack(alignment: .leading) { // open-vstack-2
                        Text("Find your Job ")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                        
                        Text(dateFormatter.string(from: Date())) // Displaying current date
                            .font(.caption)
                            .foregroundColor(.white)
                        
                    } // close-open-vstack-2
                    .padding()
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 72.0/255.0, blue: 20.0/255.0), Color(red: 1.0, green: 156.0/255.0, blue: 34.0/255.0)]), startPoint: .leading, endPoint: .trailing)
                    ) // close-vstack
                    .cornerRadius(10)
                    .padding(.top)
                    .padding(.all)
                    
                    // *** tab-content-view  ***
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
                    .offset(y: 65)

                    
                    
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
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
