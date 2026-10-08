//
//  MockCourseCache.swift
//  LearningDashboardTests
//
//  Created by Komal Bohra on 08/10/26.
//

import Foundation
@testable import LearningDashboard

final class MockCourseCache: CourseCacheProtocol {

    var courses: [Course] = []

    func exists() -> Bool {
        !courses.isEmpty
    }

    func save(_ courses: [Course]) throws {
        self.courses = courses
    }

    func load() throws -> [Course] {
        courses
    }
}
