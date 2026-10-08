//
//  DashboardViewModel.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 07/10/26.
//

internal import Foundation
internal import Combine

@MainActor
final class DashboardViewModel: ObservableObject {

    @Published private(set) var courses: [Course] = []
    @Published private(set) var state: ViewState = .idle

    private let fetchCoursesUseCase: FetchCoursesUseCaseProtocol
    private let repository: CourseRepositoryProtocol

    init(
        fetchCoursesUseCase: FetchCoursesUseCaseProtocol,
        repository: CourseRepositoryProtocol
    ) {
        self.fetchCoursesUseCase = fetchCoursesUseCase
        self.repository = repository
    }

    func loadCourses() async {

        state = .loading

        do {
            courses = try await fetchCoursesUseCase.execute()

            state = courses.isEmpty
                ? .empty
                : .loaded

        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func refreshFromCache() {

        do {
            let cachedCourses = try repository.loadCachedCourses()

            courses = cachedCourses

            state = cachedCourses.isEmpty
                ? .empty
                : .loaded

        } catch {
            print(
                "Unable to refresh dashboard from cache:",
                error
            )
        }
    }
}
