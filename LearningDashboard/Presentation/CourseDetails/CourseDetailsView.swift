//
//  CourseDetailsView.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 08/10/26.
//

import SwiftUI
internal import Foundation
internal import Combine
struct CourseDetailsView: View {

    @StateObject private var viewModel: CourseDetailsViewModel

    init(
        course: Course,
        repository: CourseRepositoryProtocol
    ) {
        _viewModel = StateObject(
            wrappedValue: CourseDetailsViewModel(
                course: course,
                repository: repository
            )
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                courseHeader

                Divider()

                lessonsSection
            }
            .padding()
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Course Header

    private var courseHeader: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text(viewModel.course.title)
                .font(.title2)
                .fontWeight(.bold)

            Text("Instructor: \(viewModel.course.instructor)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text("Progress")
                .font(.headline)

            ProgressView(
                value: Double(viewModel.course.progress),
                total: 100
            )

            Text("\(viewModel.course.progress)% Complete")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Lessons

    private var lessonsSection: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("Lessons")
                .font(.title3)
                .fontWeight(.semibold)

            ForEach(viewModel.course.lessons) { lesson in
                lessonRow(lesson)
            }
        }
    }

    // MARK: - Lesson Row

    private func lessonRow(_ lesson: Lesson) -> some View {
        Button {
            viewModel.markLessonCompleted(lesson)
        } label: {
            HStack(spacing: 12) {

                Image(
                    systemName: lesson.isCompleted
                    ? "checkmark.circle.fill"
                    : "circle"
                )
                .font(.title3)
                .foregroundStyle(
                    lesson.isCompleted
                    ? .green
                    : .secondary
                )

                Text(lesson.title)
                    .foregroundStyle(.primary)

                Spacer()

                Text(
                    lesson.isCompleted
                    ? "Completed"
                    : "Pending"
                )
                .font(.caption)
                .foregroundStyle(
                    lesson.isCompleted
                    ? .green
                    : .secondary
                )
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
        .disabled(lesson.isCompleted)
    }
}
