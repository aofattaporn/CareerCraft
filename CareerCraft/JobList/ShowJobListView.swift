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
    @State private var selectedItem: Job?
    
    @State private var searchJob: String = ""
    
    @State private var showDeleteSheet:Bool = false
    @State var showAlert = false
    
    @State private var showFilterJobSheet:Bool = false
    @State private var filterWorkStyleIndex: Int = -1
    @State private var filterWorkTimeIndex: Int = -1
    @State private var filterMinSalary: String = ""
    @State private var filterMaxSalary: String = ""
    @State private var filterApplied: AppliedState = .unknown

    
    @State var showAddItemView = false
        
    private func checkFilterDirty() ->Bool {
        if (
            filterWorkStyleIndex == -1 &&
            filterWorkTimeIndex == -1 &&
            filterMinSalary == "" &&
            filterMaxSalary == "" &&
            filterApplied == .unknown
        ) {
            return false
        } else {
            return true
        }
    }
    

    var searchResults: [Job] {
        
        // Filter job
        
        var filterJob = jobs
        
        if(checkFilterDirty()) {
            
            if filterApplied != AppliedState.unknown {
                filterJob = filterJob.filter { $0.appliedState == filterApplied }
            }
            
            if filterWorkStyleIndex != -1 {
                filterJob = filterJob.filter { $0.workStyle == Constants.Job.WorkStyle[filterWorkStyleIndex] }
            }
            
            if filterWorkTimeIndex != -1 {
                filterJob = filterJob.filter { $0.workTime == Constants.Job.workTimes[filterWorkTimeIndex] }
            }
            
            if let min = Int(filterMinSalary) {
                filterJob = filterJob.filter { Int($0.minSalary ?? 0) >= min }
            }
            
            if let max = Int(filterMaxSalary) {
                filterJob = filterJob.filter { Int($0.maxSalary ?? 0) <= max  }
            }
            
        }
        return searchJob.isEmpty ? filterJob : filterJob.filter { $0.company.lowercased().contains(searchJob.lowercased())  ||
            $0.department.lowercased().contains(searchJob.lowercased())
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
                    ZStack{
                        Image(systemName: "slider.horizontal.3")
                             .padding()
                             .foregroundColor(Color("secondary-app"))
                             .font(.system(size: 24))
                        
                        if(checkFilterDirty()){
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(.red)
                                .offset(x: 16, y: -10)
                        }
                    }
                } // close-filtern-btn
                .sheet(isPresented: $showFilterJobSheet) {
                    if #available(iOS 16.0, *) {
                        FilterJobSheet(
                            filterApplied: $filterApplied,
                            filterWorkStyleIndex: $filterWorkStyleIndex,
                            filterWorkTimeIndex: $filterWorkTimeIndex,
                            filterMinSalary: $filterMinSalary,
                            filterMaxSalary: $filterMaxSalary
                            )
                            .presentationDetents([.fraction(0.70)])
                    
                    }
                }
            } // close-hstack
            
            // *** background-canvas ***
            ZStack { // open-ztack
                
                ScrollView([.vertical]){ // open-scrollview-1
                    VStack {
                        if searchResults.isEmpty {
                            Text("No Result Found")
                        }else {
                            ForEach(searchResults) { item in
                                    JobItemView(jobItem: item)
                                    .onTapGesture {
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
                                 .background(Color("primary-app"))
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
