//
//  ActionButtonView.swift
//  Accidents
//
//  Created by Marcel Mravec on 22.04.2024.
//

import SwiftUI

struct ActionButtonView: View {
    let presenter: AccidentsPresenter
    let vehicleManager: VehicleManager
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ACButton(label: "Exit and save", systemImage: "checkmark.circle") {
                    let blueVehicle = vehicleManager.vehicles.first(where: { $0.imageName.contains("blue") })
                    let yellowVehicle = vehicleManager.vehicles.first(where: { $0.imageName.contains("yellow") })
                    let otherVehicles = vehicleManager.vehicles.filter { !$0.imageName.contains("blue") && !$0.imageName.contains("yellow") }
                    presenter.saveVehiclesToAccidentSituation(blueVehicle: blueVehicle, yellowVehicle: yellowVehicle, otherVehicles: otherVehicles)
                    presenter.createReportAndSave()
                }
                ACButton(label: "Save & Go next", systemImage: "goforward.plus") {
                    presenter.goNext()
                }
            }
        }
        .padding()
    }
    
    
}


#Preview {
    ActionButtonView(presenter: MockPresenter(repository: MockDataRepository()), vehicleManager: VehicleManager())
}
