//
//  CourseRepositoryProtocol.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 07/10/26.
//

internal import Foundation

protocol CourseRepositoryProtocol {
    func fetchCourses() async throws -> [Course]
    func saveCourses(_ courses: [Course]) throws
    func loadCachedCourses() throws -> [Course]
}

