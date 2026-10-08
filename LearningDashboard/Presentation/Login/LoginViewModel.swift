//
//  LoginViewModel.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 07/10/26.
//

internal import Foundation
import SwiftUI
internal import Combine
@MainActor
final class LoginViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isLoggedIn = false

    func login() async {

        errorMessage = nil

        guard !email.isEmpty else {
            errorMessage = "Please enter your email."
            return
        }

        guard email.contains("@") else {
            errorMessage = "Please enter a valid email."
            return
        }

        guard !password.isEmpty else {
            errorMessage = "Please enter your password."
            return
        }

        guard password.count >= 6 else {
            errorMessage = "Password must contain at least 6 characters."
            return
        }

        isLoading = true

        defer {
            isLoading = false
        }

        do {
            try await Task.sleep(for: .seconds(1))
            isLoggedIn = true
        } catch {
            errorMessage = "Login failed. Please try again."
        }
    }
}
