import SwiftUI
import SwiftData
import PhotosUI

struct AddJobView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    let workStyles: [WorkStyle] = [.onsite, .online, .hybrid]
    let workTimes: [WorkTime] = [.flexible, .fixed]
    
    @Binding var myJob: Job?
    
    @State private var company: String = ""
    @State private var department: String = ""
    @State private var minSalary: String = ""
    @State private var maxSalary: String = ""
    @State private var location: String = ""
    @State private var workStyleIndex: Int = 0
    @State private var workTimeIndex: Int = 0
    @State private var hasbonusFrequency: Bool = false
    @State private var hasSocialSecurity: Bool = false
    @State private var hasProvidentFund: Bool = false
    @State private var hasEquipment: Bool = false
    
    @State var sekectedCategory: Category?
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    
    private func addItem() {
        let newJob = Job(
            company: company,
            department: department,
            minSalary: minSalary,
            maxSalary: maxSalary,
            location: location,
            workStyleIndex: workStyleIndex,
            workTimeIndex: workTimeIndex,
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
            myJob?.minSalary = minSalary
            myJob?.maxSalary = maxSalary
            myJob?.workStyleIndex = workStyleIndex
            myJob?.workTimeIndex = workTimeIndex
            myJob?.hasProvidentFund = hasProvidentFund
            myJob?.hasbonusFrequency = hasbonusFrequency
            myJob?.hasSocialSecurity = hasSocialSecurity
            myJob?.hasEquipment = hasEquipment
            myJob?.imageData = selectedPhotoData
        }
        
        myJob = nil
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
                        updateItem(myJob!)
                    } else {
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
                                workTimeIndex = 3
                            }) {
                                if workTimeIndex < 3 && workTimeIndex != -1  {
                                    Text("Clear")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        Picker(selection: $workTimeIndex, label: Text("")) {
                            ForEach(0 ..< 2) {
                                Text(self.workTimes[$0].rawValue)
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
                                if workStyleIndex < 3 && workStyleIndex != -1 {
                                    Text("Clear")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        Picker(selection: $workStyleIndex, label: Text("")) {
                            ForEach(0 ..< 3) {
                                Text(self.workStyles[$0].rawValue)
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
                department = job.department ?? ""
                location = job.location ?? ""
                minSalary = job.minSalary ?? ""
                maxSalary = job.maxSalary ?? ""
                workStyleIndex = job.workStyleIndex ?? -1
                workTimeIndex = job.workTimeIndex ?? -1
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


struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
    }
}

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Spacer()
                    if !text.isEmpty {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 8)
                    }
                }
            )
    }
}


struct NumberTextField: View {
    
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .keyboardType(.numberPad)
                .overlay(
                    HStack {
                        Spacer()
                        Text("B")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                )

        }
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 20.0) {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
            
        }
    }
}
