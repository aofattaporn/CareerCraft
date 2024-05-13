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
                                .foregroundColor(Color("secondary-app"))
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
