//
//  ViewState.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 08/10/26.
//

internal import Foundation

enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case empty
    case error(String)
}
