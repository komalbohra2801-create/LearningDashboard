//
//  MockCourseRepository.swift
//  LearningDashboardTests
//
//  Created by Komal Bohra on 08/10/26.
//

import Foundation
@testable import LearningDashboard

final class MockCourseRepository: CourseRepositoryProtocol {

    var courses: [Course]

    init(courses: [Course] = []) {
        self.courses = courses
    }

    func fetchCourses() async throws -> [Course] {
        return courses
    }

    func saveCourses(_ courses: [Course]) throws {
        self.courses = courses
    }

    func loadCachedCourses() throws -> [Course] {
        return courses
    }
}
