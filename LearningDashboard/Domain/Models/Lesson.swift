//
//  Lesson.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 07/10/26.
//

internal import Foundation

struct Lesson: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    var isCompleted: Bool
}
