//
//  ContentView.swift
//  CareerCraft
//
//  Created by attaporn on 4/17/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State var selectedTab = Tabs.ShowJobListView


    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
        

        
        VStack(alignment: .leading) { // opne-vstack
                    
            ZStack { // open-zstack
                
                VStack(alignment: .leading) { // open-vstack-2
                    Text("Find Your the best Job ")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                    
                    Text("Mon Apr 2024")
                        .font(.caption)
                        .foregroundColor(.white)
                } // close-open-vstack-2
                .padding()
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 72.0/255.0, blue: 20.0/255.0), Color(red: 1.0, green: 156.0/255.0, blue: 34.0/255.0)]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(10)
                
                
                
                HStack(spacing: 5) { // open-hstack
                    Text("Second tab")
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color("Background"))
                        .cornerRadius(5)
                        .onTapGesture {
                            self.selectedTab = .ShowJobListView
                        }
                    Text("Second tab")
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color("Background"))
                        .cornerRadius(5)
                        .onTapGesture {
                            self.selectedTab = .CompareJobView
                        }
                } // close-hstack
                .padding(.all)
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
                .offset(y: 55)
                
            } // close-zstck
                    
        } // close-v-stack
        .padding(.all)
        
        
        // View from taping ***
        VStack { // open-vstack
            if selectedTab == .ShowJobListView {
                ShowJobListView()
            } else {
                CompareJobView()
            }
        } // close-vstack
        .padding(.top)
        

        Spacer()

        
        
        
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

enum Tabs {
    case ShowJobListView
    case CompareJobView
}
