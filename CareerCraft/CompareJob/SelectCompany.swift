import SwiftUI
import SwiftData

struct SelectCompany: View {
    @State private var searchKeyword: String = ""
    @Query private var jobs: [Job]
    
    @Binding var company1: Job?
    @Binding var company2: Job?
    @Binding var selectorNum: Int
    
    var searchResults: [Job] {
        return searchKeyword.isEmpty ? jobs : jobs.filter { $0.company.lowercased().contains(searchKeyword.lowercased()) }
    }
    
    var body: some View {
        NavigationView {
            List(searchResults) { job in
                Button(action: {
                    if self.selectorNum == 1 {
                        self.company1 = job
                    } else {
                        self.company2 = job
                    }
                }) {
                    HStack {
                        Text(job.company)
                        Spacer()
                        if isSelected(job: job) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color("secondary"))
                        }
                    }
                }
                .disabled(isSelected(job: job))
            }
            .listStyle(.inset)
            .searchable(text: $searchKeyword)
        }
    }
    
    func isSelected(job: Job) -> Bool {
        if self.selectorNum == 1 {
            return job.company == company1?.company
        } else {
            return job.company == company2?.company
        }
    }
}

struct SelectCompany_Previews: PreviewProvider {
    static var previews: some View {
        SelectCompany(company1: .constant(Job(company: "Company A", department: "Engineering", salaryRange: "$50,000 - $70,000", location: "New York", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true)),
                      company2: .constant(Job(company: "Company B", department: "Marketing", salaryRange: "$40,000 - $60,000", location: "San Francisco", workStyle: .hybrid, workTime: .flexible, hasbonusFrequency: false, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true)), selectorNum: .constant(1))
    }
}
