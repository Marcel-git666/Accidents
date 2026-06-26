//
//  PreloadDataView.swift
//  Accidents
//
//  Created by Marcel Mravec on 04.03.2024.
//

import SwiftUI

struct PreloadDataView: View {
    // Použijeme tvůj existující ViewModel
    @State private var viewModel = DriverViewModel()
    @State private var showSuccessAlert = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Enter your details here. They will be automatically prefilled as Driver A when you create a new accident report.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    // Znovupoužití tvého formuláře pro řidiče
                    DriverView(model: viewModel)
                    
                    Button(action: saveProfile) {
                        Text("Save Profile")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("My Profile")
            .onAppear {
                // Při zobrazení záložky načteme uložená data, pokud existují
                if let savedProfile = ProfileManager.shared.loadProfile() {
                    viewModel.driver = savedProfile
                }
            }
            .alert("Profile Saved", isPresented: $showSuccessAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Your data has been saved securely on this device.")
            }
        }
    }
    
    private func saveProfile() {
        ProfileManager.shared.saveProfile(viewModel.driver)
        showSuccessAlert = true
    }
}

#Preview {
    PreloadDataView()
}
