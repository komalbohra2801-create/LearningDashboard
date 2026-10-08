//
//  MockAPIClient.swift
//  LearningDashboardTests
//
//  Created by Komal Bohra on 08/10/26.
//

import Foundation
@testable import LearningDashboard

final class MockAPIClient: APIClientProtocol {

    var fetchCallCount = 0

    func fetchCourses() async throws -> [Course] {
        fetchCallCount += 1
        return []
    }
}
