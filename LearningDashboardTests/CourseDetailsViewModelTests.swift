//
//  CourseDetailsViewModelTests.swift
//  LearningDashboardTests
//
//  Created by Komal Bohra on 08/10/26.
//

import Testing
@testable import LearningDashboard

@MainActor
struct CourseDetailsViewModelTests {

    @Test
    func completingLessonUpdatesProgress() throws {

        // Given: Course with 50% progress
        let course = Course(
            id: 1,
            title: "Python Programming",
            instructor: "John Smith",
            progress: 50,
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
                    isCompleted: false
                ),
                Lesson(
                    id: 4,
                    title: "OOP",
                    isCompleted: false
                )
            ]
        )

        let repository = MockCourseRepository(
            courses: [course]
        )

        let viewModel = CourseDetailsViewModel(
            course: course,
            repository: repository
        )

        // When: Complete the third lesson
        viewModel.markLessonCompleted(
            course.lessons[2]
        )

        // Then: Progress should become 75%
        #expect(viewModel.course.progress == 75)

        // Lesson should be completed
        #expect(viewModel.course.lessons[2].isCompleted)

        // Updated progress should be saved
        #expect(repository.courses[0].progress == 75)

        // Updated lesson state should be saved
        #expect(repository.courses[0].lessons[2].isCompleted)
    }

    @Test
    func completingAlreadyCompletedLessonDoesNotChangeProgress() throws {

        // Given
        let course = Course(
            id: 1,
            title: "Swift Programming",
            instructor: "John Smith",
            progress: 50,
            lessons: [
                Lesson(id: 1, title: "Introduction", isCompleted: true),
                Lesson(id: 2, title: "Variables", isCompleted: false)
            ]
        )

        let repository = MockCourseRepository(
            courses: [course]
        )

        let viewModel = CourseDetailsViewModel(
            course: course,
            repository: repository
        )

        // When: Tap an already completed lesson
        viewModel.markLessonCompleted(
            course.lessons[0]
        )

        // Then: Progress should remain unchanged
        #expect(viewModel.course.progress == 50)
        #expect(viewModel.course.lessons[0].isCompleted)
        #expect(repository.courses[0].progress == 50)
    }
}
