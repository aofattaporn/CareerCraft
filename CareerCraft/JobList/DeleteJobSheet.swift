//
//  DeleteJobSheet.swift
//  CareerCraft
//
//  Created by attaporn on 4/19/24.
//

import SwiftUI
import SwiftData

struct DeleteJobSheet: View {
    
    let job: Job
    @Query private var jobs: [Job]
    @Environment(\.modelContext) private var modelContext
    
    // function-remove-job
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let jobToDelete = jobs[index]
                modelContext.delete(jobToDelete)
            }
        }
    }


    var body: some View {
        VStack {
            Text("Delete \(job.company) job?")
                .padding()
            HStack {
                Spacer()
                Button("Delete") {
                    deleteItems(self.job)
                }
                .foregroundColor(.red)
                .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    DeleteJobSheet(        Job(company: "Company A", department: "Engineering", salaryRange: "$50,000 - $70,000", location: "New York", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true))
}
