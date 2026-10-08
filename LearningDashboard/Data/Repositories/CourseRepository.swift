//
//  CourseRepository.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 07/10/26.
//

internal import Foundation

final class CourseRepository: CourseRepositoryProtocol {

    private let apiClient: APIClientProtocol
    private let cache: CourseCacheProtocol

    init(
        apiClient: APIClientProtocol,
        cache: CourseCacheProtocol
    ) {
        self.apiClient = apiClient
        self.cache = cache
    }

    func fetchCourses() async throws -> [Course] {

        if cache.exists() {
            do {
                return try cache.load()
            } catch {
                print("Cache load failed:", error)
            }
        }

        let courses = try await apiClient.fetchCourses()

        try cache.save(courses)

        return courses
    }

    func saveCourses(_ courses: [Course]) throws {
        try cache.save(courses)
    }

    func loadCachedCourses() throws -> [Course] {
        try cache.load()
    }
}
