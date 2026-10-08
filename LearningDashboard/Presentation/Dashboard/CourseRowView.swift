//
//  CourseRowView.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 08/10/26.
//

import SwiftUI

struct CourseRowView: View {

    let course: Course

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // Course Title
            Text(course.title)
                .font(.headline)
                .fontWeight(.semibold)

            // Instructor
            Text(course.instructor)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            // Progress
            VStack(alignment: .leading, spacing: 6) {

                HStack {
                    Text("Progress")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Text("\(course.progress)%")
                        .font(.caption)
                        .fontWeight(.medium)
                }

                ProgressView(
                    value: Double(course.progress),
                    total: 100
                )
            }

            // Lessons + Continue
            HStack {

                Label(
                    "\(course.lessons.count) Lessons",
                    systemImage: "book"
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                Spacer()

                Text("Continue")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Image(systemName: "chevron.right")
                    .font(.caption)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        }
    }
}
