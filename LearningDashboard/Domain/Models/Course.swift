//
//  Course.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 07/10/26.
//

internal import Foundation

struct Course: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let instructor: String
    var progress: Int
    var lessons: [Lesson]
}
