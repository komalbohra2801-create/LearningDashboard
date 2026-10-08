//
//  CourseDetailsViewModel.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 08/10/26.
//

internal import Foundation
internal import Combine

@MainActor
final class CourseDetailsViewModel: ObservableObject {

    @Published private(set) var course: Course
    @Published private(set) var errorMessage: String?

    private let repository: CourseRepositoryProtocol

    init(
        course: Course,
        repository: CourseRepositoryProtocol
    ) {
        self.course = course
        self.repository = repository
    }

    func markLessonCompleted(_ lesson: Lesson) {

        guard !lesson.isCompleted else {
            return
        }

        guard let lessonIndex = course.lessons.firstIndex(
            where: { $0.id == lesson.id }
        ) else {
            return
        }

        // 1. Complete lesson
        course.lessons[lessonIndex].isCompleted = true

        // 2. Recalculate progress
        updateProgress()

        // 3. Persist updated course
        saveUpdatedCourse()
    }

    private func updateProgress() {

        guard !course.lessons.isEmpty else {
            course.progress = 0
            return
        }

        let completedCount = course.lessons.filter {
            $0.isCompleted
        }.count

        course.progress = Int(
            Double(completedCount)
            / Double(course.lessons.count)
            * 100
        )
    }

    private func saveUpdatedCourse() {

        do {
            var courses = try repository.loadCachedCourses()

            guard let courseIndex = courses.firstIndex(
                where: { $0.id == course.id }
            ) else {
                return
            }

            courses[courseIndex] = course

            try repository.saveCourses(courses)

            print("✅ Course progress saved")

        } catch {
            errorMessage = "Unable to save course progress."
            print("❌ Save error:", error)
        }
    }
}
