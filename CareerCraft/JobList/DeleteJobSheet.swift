//
//  DeleteJobSheet.swift
//  CareerCraft
//
//  Created by attaporn on 4/19/24.
//

import SwiftUI
import SwiftData

struct DeleteJobSheet: View {
    
    var job: Job
    @Query private var jobs: [Job]
    @Environment(\.modelContext) private var modelContext
    
    // function-remove-job
    private func deleteItem() {
        withAnimation {
            if let index = jobs.firstIndex(of: job) {
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
                    deleteItem()
                }
                .foregroundColor(.red)
                .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    DeleteJobSheet(   job:  Job(company: "Company A", department: "Engineering", salaryRange: "$50,000 - $70,000", location: "New York", workStyle: .onsite, workTime: .fixed, hasbonusFrequency: true, hasSocialSecurity: true, hasProvidentFund: true, hasEquipment: true))
}
