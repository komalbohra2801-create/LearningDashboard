//
//  DashboardView.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 08/10/26.
//

import SwiftUI

struct DashboardView: View {

    @StateObject private var viewModel: DashboardViewModel

    private let repository: CourseRepositoryProtocol

    init(repository: CourseRepositoryProtocol) {

        self.repository = repository

        let useCase = FetchCoursesUseCase(
            repository: repository
        )

        _viewModel = StateObject(
            wrappedValue: DashboardViewModel(
                fetchCoursesUseCase: useCase,
                repository: repository
            )
        )
    }

    var body: some View {
        Group {
            switch viewModel.state {

            case .idle, .loading:
                loadingView

            case .loaded:
                courseList

            case .empty:
                emptyView

            case .error(let message):
                errorView(message)
            }
        }
        .navigationTitle("My Courses")
        .navigationBarTitleDisplayMode(.large)
        .task {
            if case .idle = viewModel.state {
                await viewModel.loadCourses()
            }
        }
    }

    // MARK: - Loading

    private var loadingView: some View {
        VStack(spacing: 12) {
            ProgressView()

            Text("Loading courses...")
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Course List

    private var courseList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {

                ForEach(viewModel.courses) { course in

                    NavigationLink {
                        CourseDetailsView(
                            course: course,
                            repository: repository
                        )
                        .onDisappear {
                            viewModel.refreshFromCache()
                        }

                    } label: {
                        CourseRowView(course: course)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }

    // MARK: - Empty

    private var emptyView: some View {
        ContentUnavailableView(
            "No Courses",
            systemImage: "book.closed",
            description: Text(
                "There are currently no courses available."
            )
        )
    }

    // MARK: - Error

    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {

            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(.orange)

            Text("Unable to Load Courses")
                .font(.headline)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button("Retry") {
                Task {
                    await viewModel.loadCourses()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
