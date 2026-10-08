//
//  FetchCoursesUseCase.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 07/10/26.
//

internal import Foundation

protocol FetchCoursesUseCaseProtocol {
    func execute() async throws -> [Course]
}

final class FetchCoursesUseCase: FetchCoursesUseCaseProtocol {

    private let repository: CourseRepositoryProtocol

    init(repository: CourseRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [Course] {
        try await repository.fetchCourses()
    }
}
