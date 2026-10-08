//
//  APIClient.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 07/10/26.
//

internal import Foundation

protocol APIClientProtocol {
    func fetchCourses() async throws -> [Course]
}

final class APIClient: APIClientProtocol {

    func fetchCourses() async throws -> [Course] {

        try await Task.sleep(for: .seconds(1))


        guard let url = Bundle.main.url(
            forResource: "courses",
            withExtension: "json"
        ) else {
            print("❌ courses.json NOT FOUND")
            throw APIError.fileNotFound
        }

        print("✅ courses.json FOUND:", url)

        let data = try Data(contentsOf: url)

        do {
            let courses = try JSONDecoder().decode(
                [Course].self,
                from: data
            )

            print("✅ Decoded \(courses.count) courses")

            return courses

        } catch {
            print("❌ DECODING FAILED")
            print(error)

            throw error
        }
    }
}

enum APIError: LocalizedError {
    case fileNotFound
    case invalidData

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "courses.json was not found."
        case .invalidData:
            return "Unable to load course data."
        }
    }
}
