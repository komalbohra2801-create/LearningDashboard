//
//  LoginView.swift
//  LearningDashboard
//
//  Created by Komal Bohra on 07/10/26.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel = LoginViewModel()

    private let repository: CourseRepositoryProtocol

    init(repository: CourseRepositoryProtocol) {
        self.repository = repository
    }

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                Text("Learning Dashboard")
                    .font(.largeTitle)
                    .bold()

                TextField(
                    "Email",
                    text: $viewModel.email
                )
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)

                SecureField(
                    "Password",
                    text: $viewModel.password
                )
                .textFieldStyle(.roundedBorder)

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(.caption)
                }

                Button {
                    Task {
                        await viewModel.login()
                    }
                } label: {

                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isLoading)

                Spacer()
            }
            .padding()
            .navigationDestination(
                isPresented: $viewModel.isLoggedIn
            ) {
                DashboardView(
                    repository: repository
                )
            }
        }
    }
}
