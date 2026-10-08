//
//  LearningDashboardTests.swift
//  LearningDashboardTests
//
//  Created by Komal Bohra on 07/10/26.
//

import Testing
@testable import LearningDashboard

struct LearningDashboardTests {

    @Test
    func repositoryReturnsCachedCourses() async throws {

        // Given
        let cachedCourse = Course(
            id: 1,
            title: "Python Programming",
            instructor: "John Smith",
            progress: 75,
            lessons: [
                Lesson(
                    id: 1,
                    title: "Introduction",
                    isCompleted: true
                ),
                Lesson(
                    id: 2,
                    title: "Variables",
                    isCompleted: true
                ),
                Lesson(
                    id: 3,
                    title: "Functions",
                    isCompleted: true
                ),
                Lesson(
                    id: 4,
                    title: "OOP",
                    isCompleted: false
                )
            ]
        )

        let apiClient = MockAPIClient()
        let cache = MockCourseCache()
        cache.courses = [cachedCourse]

        let repository = CourseRepository(
            apiClient: apiClient,
            cache: cache
        )

        // When
        let courses = try await repository.fetchCourses()

        // Then
        #expect(courses.count == 1)
        #expect(courses[0].progress == 75)
        #expect(courses[0].lessons[2].isCompleted)
        #expect(apiClient.fetchCallCount == 0)
    }
    
    
}
