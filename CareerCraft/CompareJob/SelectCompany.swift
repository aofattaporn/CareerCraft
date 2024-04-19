import SwiftUI
import SwiftData



struct SelectCompany: View {
    
    @State private var searchKeyword: String = ""
    @Query private var jobs: [Job]
    
    var searchResults: [Job] {
        return searchKeyword.isEmpty ? jobs : jobs.filter({ item in
            item.company.lowercased().contains(searchKeyword.lowercased())
        })}
    
    var body: some View {
            
        NavigationView {
            List(searchResults) { job in
                Text(job.company)
            }
            .listStyle(.inset)
            .searchable(text: $searchKeyword)
        }
                
    }
}

#Preview {
    SelectCompany()
}
