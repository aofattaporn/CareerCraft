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

struct ShowJobListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var jobs: [Job]
    
    @State private var searchJob: String = ""
    @State private var showFilterJobSheet = false
    
    @State private var showDeleteSheet = false
    @State private var selectedItem: Job?
    
    @State var showAlert = false
    @State var showAddItemView = false
    
    @State  var filterMinSalary: String = ""
    @State  var filterMaxSalary: String = ""

    @State  var filterHasbonusFrequency: Bool = false
    @State  var filterHasSocialSecurity: Bool = false
    @State  var filterHasProvidentFund: Bool = false
    @State  var filterHasEquipment: Bool = false
    
    @State private var companyName: String = ""
    @State private var departmentName: String = ""
    @State private var location: String = ""
    @State private var minSalary: String = ""
    @State private var maxSalary: String = ""
    @State private var workStyleIndex: Int = 4
    @State private var workTimeIndex: Int = 4
    @State private var hasbonusFrequency: Bool = false
    @State private var hasSocialSecurity: Bool = false
    @State private var hasProvidentFund: Bool = false
    @State private var hasEquipment: Bool = false
    
    @State private var isEditing: Bool = false
    @State private var isCreating: Bool = true
    
    var searchResults: [Job] {
        return searchJob.isEmpty ? jobs : jobs.filter { $0.company.lowercased().contains(searchJob.lowercased())  ||
            $0.department!.lowercased().contains(searchJob.lowercased())
        }
    }

    var body: some View {
        VStack(alignment: .center) { // open-vstack
        
            // *** textField-for-searching ***
            TextField("Search Company or Department", text: $searchJob)
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
                        FilterJobSheet(
                            filterMinSalary: $filterMinSalary,
                            filterMaxSalary: $filterMaxSalary,
                            workStyleIndex:  $workStyleIndex,
                            workTimeIndex:   $workTimeIndex,
                            filterHasbonusFrequency: $filterHasbonusFrequency,
                            filterHasSocialSecurity: $filterHasbonusFrequency,
                            filterHasProvidentFund:$filterHasbonusFrequency,
                            filterHasEquipment: $filterHasbonusFrequency
                        )
                            .presentationDetents([.fraction(0.75)])
                    
                    }
                }
            } // close-hstack
            
            // *** background-canvas ***
            ZStack { // open-ztack
                
                ScrollView([.vertical]){ // open-scrollview-1
                    VStack {
                        ForEach(searchResults) { item in
                                JobItemView(jobItem: item)
                                .onTapGesture {
                                    self.companyName = item.company
                                    self.departmentName = item.department ?? ""
                                    self.location = item.location ?? ""
                                    self.minSalary = item.minSalary ?? ""
                                    self.maxSalary = item.maxSalary ?? ""
                                    self.workStyleIndex = 4
                                    self.workTimeIndex = 4
                                    self.hasbonusFrequency = item.hasbonusFrequency
                                    self.hasSocialSecurity = item.hasSocialSecurity
                                    self.hasProvidentFund = item.hasProvidentFund
                                    self.hasEquipment = item.hasEquipment
                                    
                                    self.selectedItem = item
                                    self.showAddItemView.toggle()
                                }
                                .fullScreenCover(isPresented: $showAddItemView){
                                    AddJobView(myJob: $selectedItem)
                                }
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
                            self.selectedItem = nil
                            self.showAddItemView.toggle()
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
                        .fullScreenCover(isPresented: $showAddItemView){
                            // TODO : When add pass null ?
                            AddJobView(myJob:.constant(nil))

                        }
                    } // close-hstack
                     
                } // close-vstack-3
            }
        }
        
    } // close-vstack
    
    
    // function-remove-job
    private func deleteItems(job: Job) {
        withAnimation {
            modelContext.delete(job)
        }
    }

}

#Preview {
    ShowJobListView()
}
