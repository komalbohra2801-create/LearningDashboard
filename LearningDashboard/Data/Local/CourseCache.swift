//
//  CourseCache.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 07/10/26.
//

internal import Foundation

protocol CourseCacheProtocol {
    func save(_ courses: [Course]) throws
    func load() throws -> [Course]
    func exists() -> Bool
}

final class CourseCache: CourseCacheProtocol {

    private let fileName = "courses_cache.json"

    private var fileURL: URL {
        FileManager.default
            .urls(
                for: .documentDirectory,
                in: .userDomainMask
            )[0]
            .appendingPathComponent(fileName)
    }

    func save(_ courses: [Course]) throws {
        let data = try JSONEncoder().encode(courses)

        try data.write(
            to: fileURL,
            options: .atomic
        )
    }

    func load() throws -> [Course] {
        let data = try Data(contentsOf: fileURL)

        return try JSONDecoder().decode(
            [Course].self,
            from: data
        )
    }

    func exists() -> Bool {
        FileManager.default.fileExists(
            atPath: fileURL.path
        )
    }
}
