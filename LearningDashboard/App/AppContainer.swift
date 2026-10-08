//
//  AppContainer.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 07/10/26.
//

internal import Foundation

final class AppContainer {

    let repository: CourseRepositoryProtocol

    init() {
        let apiClient = APIClient()
        let cache = CourseCache()

        repository = CourseRepository(
            apiClient: apiClient,
            cache: cache
        )
    }

    func makeFetchCoursesUseCase() -> FetchCoursesUseCase {
        FetchCoursesUseCase(
            repository: repository
        )
    }
}
