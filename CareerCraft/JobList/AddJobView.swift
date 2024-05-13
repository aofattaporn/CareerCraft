import SwiftUI
import SwiftData
import PhotosUI

struct AddJobView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Binding var myJob: Job?
    
    @State private var company: String = ""
    @State private var department: String = ""
    @State private var location: String = ""
    
    @State private var minSalary: String = ""
    @State private var maxSalary: String = ""
    
    @State private var workStyleIndex: Int = -1
    @State private var workTimeIndex: Int = -1
    
    @State private var hasbonusFrequency: Bool = false
    @State private var hasSocialSecurity: Bool = false
    @State private var hasProvidentFund: Bool = false
    @State private var hasEquipment: Bool = false
        
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    
    private func addItem() {
        let newJob = Job(
            company: company,
            department: department,
            location: location,
            
            minSalary: Int(minSalary),
            maxSalary: Int(maxSalary),
            
            workStyleValue: (workStyleIndex == -1 ? WorkStyle.unknown : Constants.Job.WorkStyle[workStyleIndex]),
            workTimeValue:  (workTimeIndex == -1 ? WorkTime.unknown : Constants.Job.workTimes[workTimeIndex]),
        
            hasbonusFrequency: hasbonusFrequency,
            hasSocialSecurity: hasSocialSecurity,
            hasProvidentFund: hasProvidentFund,
            hasEquipment: hasEquipment,
            imageData: selectedPhotoData
        )
        
        withAnimation {
            modelContext.insert(newJob)
        }
        
    }
    
    private func updateItem(_ item: Job) {
        withAnimation {
            myJob?.company = company
            myJob?.department = department
            myJob?.location = location
            
            myJob?.minSalary = Int(minSalary)
            myJob?.maxSalary = Int(maxSalary)
            
            myJob?.workStyle = workStyleIndex == -1 ? WorkStyle.unknown : Constants.Job.WorkStyle[workStyleIndex]
            myJob?.workTime = workTimeIndex == -1 ? WorkTime.unknown :
            Constants.Job.workTimes[workTimeIndex]
            
            myJob?.hasProvidentFund = hasProvidentFund
            myJob?.hasbonusFrequency = hasbonusFrequency
            myJob?.hasSocialSecurity = hasSocialSecurity
            myJob?.hasEquipment = hasEquipment
            
            myJob?.imageData = selectedPhotoData
        }
        
        myJob = nil
    }
    
    private func switchSalary() {
        if let minInt = Int(minSalary), let maxInt = Int(maxSalary)  {
            if(minInt > maxInt) {
                let tempMin = minInt
                minSalary = "\(maxInt)"
                maxSalary = "\(tempMin)"
            }
        }
    }

    
    var body: some View { // open-view
        VStack(alignment: .leading){ // open-vstack
            
            HStack { // open-hstack
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                }
                Spacer()
                Button(action: {
                    dismiss()
                    
                    if myJob != nil {
                        switchSalary()
                        updateItem(myJob!)
                    } else {
                        switchSalary()
                        addItem()
                    }
                    
                }) {
                    Text("Save")
                }
                .disabled(self.company == "")
            } // close-hstack
            .padding()
            
            
            ScrollView{
                
                VStack(alignment: .leading){ // open-vstack
                    
                    Section {
                        if let selectedPhotoData = selectedPhotoData,
                           let uiImage = UIImage(data: selectedPhotoData) {
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color.gray).opacity(0.5)
                                    .frame(maxHeight: 200)
                                    .cornerRadius(10)
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                                    .cornerRadius(10)
                            }
                            .padding()
                        }
                        
                        PhotosPicker(
                            selection: $selectedPhoto,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            if selectedPhotoData == nil {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.gray)
                                        .frame(height: 200)
                                        .cornerRadius(10)
                                    Image(systemName: "photo")
                                        .foregroundColor(.white)
                                }
                                .padding()
                            }
                        }
                        
                        if selectedPhotoData != nil {
                            Button(role: .destructive, action: {
                                selectedPhoto = nil
                                selectedPhotoData = nil
                            }, label: {
                                HStack{
                                    Spacer()
                                    Label("Remove Images", systemImage: "xmark")
                                        .foregroundColor(.red)
                                }
                                .padding()
                            })
                        }
                    }

                    
                    // **** company-name ****
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Company Name*")
                            .font(.headline)
                        HStack {
                            CustomTextField(text: $company, placeholder: "Enter company name")
                        }
                    }
                    .padding()
                    
                    // **** Department Name ****
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Department Name")
                            .font(.headline)
                        HStack {
                            CustomTextField(text: $department, placeholder: "Enter department name")
                        }
                    }
                    .padding()
                    
                    // **** Department Name ****
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Location")
                            .font(.headline)
                        HStack {
                            CustomTextField(text: $location, placeholder: "Enter locations")
                        }
                    }
                    .padding()
                    
                    // **** Salary Range ****
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Salary Range")
                            .font(.headline)
                        
                        HStack {
                            NumberTextField(text: $minSalary, placeholder: "Min range")
                            NumberTextField(text: $maxSalary, placeholder: "Min range")
                        }
                    }
                    .padding()
                    
                    // **** Work Time ****
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Work Time")
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                workTimeIndex = -1
                            }) {
                                if workTimeIndex != -1  {
                                    Text("Clear")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        Picker(selection: $workTimeIndex, label: Text("")) {
                            ForEach(0 ..< Constants.Job.workTimes.count, id: \.self) {
                                Text(Constants.Job.workTimes[$0].rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    
                    // **** Work Style ****
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Work Style")
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                workStyleIndex = -1
                            }) {
                                if workStyleIndex != -1 {
                                    Text("Clear")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        Picker(selection: $workStyleIndex, label: Text("")) {
                            ForEach(0 ..< Constants.Job.WorkStyle.count, id: \.self) {
                                Text(Constants.Job.WorkStyle[$0].rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    
                    
                    // **** welfare ****
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Welfare")
                            .font(.headline)
                        Toggle("Bonus", isOn: $hasbonusFrequency)
                            .toggleStyle(CheckboxToggleStyle())
                        Toggle("Social security insurance", isOn: $hasSocialSecurity)
                            .toggleStyle(CheckboxToggleStyle())
                        Toggle("Provident fund", isOn: $hasProvidentFund)
                            .toggleStyle(CheckboxToggleStyle())
                        Toggle("Equipment fund", isOn: $hasEquipment)
                            .toggleStyle(CheckboxToggleStyle())
                    }
                    .padding()
                    
                    
                    
                } // close-vstack
                
            }

            Spacer()
            
            
        } // close-vstack
        .onAppear {
            if let job = myJob {
                company = job.company
                department = job.department 
                location = job.location ?? ""
                minSalary = job.minSalary != nil ? String(job.minSalary!) : ""
                maxSalary = job.maxSalary != nil ? String(job.maxSalary!) : ""
                if let indexStyle = Constants.Job.WorkStyle.firstIndex(of: job.workStyle) {
                    workStyleIndex = indexStyle
                } else {
                    workStyleIndex = -1
                }
                if let indexTime = Constants.Job.workTimes.firstIndex(of: job.workTime) {
                    workTimeIndex = indexTime
                } else {
                    workTimeIndex = -1
                }
                hasbonusFrequency = job.hasbonusFrequency
                hasSocialSecurity = job.hasSocialSecurity
                hasProvidentFund = job.hasProvidentFund
                hasEquipment = job.hasEquipment
                selectedPhotoData = job.imageData

            } else {
                company = ""
                department = ""
                minSalary = ""
                maxSalary = ""
                location = ""
                workStyleIndex = -1
                workTimeIndex = -1
                hasbonusFrequency = false
                hasSocialSecurity = false
                hasProvidentFund = false
                hasEquipment = false
                selectedPhotoData = nil
            }
        }
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                selectedPhotoData  = data
            }
         }
    } // close-view
}
