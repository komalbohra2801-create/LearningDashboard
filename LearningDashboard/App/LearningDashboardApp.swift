//
//  LearningDashboardApp.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 07/10/26.
//

import SwiftUI

@main
struct LearningDashboardApp: App {

    private let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            LoginView(
                repository: container.repository
            )
        }
    }
}
