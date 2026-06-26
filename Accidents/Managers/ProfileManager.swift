//
//  ProfileManager.swift
//  Accidents
//
//  Created by Marcel Mravec on 25.06.2026.
//


import Foundation

struct ProfileManager {
    static let shared = ProfileManager()
    private let profileKey = "savedUserProfile"

    func saveProfile(_ driver: Driver) {
        let dict: [String: Any] = [
            "insuredName": driver.insuredName,
            "insuredAddress": driver.insuredAddress,
            "insuredPhone": driver.insuredPhone,
            "insuredPayerOfVAT": driver.insuredPayerOfVAT,
            "vehicleManufacturerAndType": driver.vehicleManufacturerAndType,
            "vehicleYearOfManufacture": driver.vehicleYearOfManufacture,
            "vehicleStateRegistrationPlate": driver.vehicleStateRegistrationPlate,
            "insurer": driver.insurer,
            "insurerBranchAddress": driver.insurerBranchAddress,
            "insuranceNumber": driver.insuranceNumber,
            "greenCardNumber": driver.greenCardNumber,
            // Datum musíme uložit jako číslo (časové razítko)
            "borderInsuranceValidUntil": driver.borderInsuranceValidUntil.timeIntervalSince1970,
            "comprehensiveInsurance": driver.comprehensiveInsurance,
            "comprehensiveInsuranceCompany": driver.comprehensiveInsuranceCompany,
            "surnameOfDriver": driver.surnameOfDriver,
            "firstNameOfDriver": driver.firstNameOfDriver,
            "addressOfDriver": driver.addressOfDriver,
            "phoneNumberOfDriver": driver.phoneNumberOfDriver,
            "driverLicenseNumber": driver.driverLicenseNumber,
            "categoryOfLicense": driver.categoryOfLicense,
            "licenseIssuedBy": driver.licenseIssuedBy
        ]
        
        UserDefaults.standard.set(dict, forKey: profileKey)
    }

    func loadProfile() -> Driver? {
        guard let dict = UserDefaults.standard.dictionary(forKey: profileKey) else {
            return nil
        }
        
        let driver = Driver()
        
        driver.insuredName = dict["insuredName"] as? String ?? ""
        driver.insuredAddress = dict["insuredAddress"] as? String ?? ""
        driver.insuredPhone = dict["insuredPhone"] as? String ?? ""
        driver.insuredPayerOfVAT = dict["insuredPayerOfVAT"] as? Bool ?? false
        driver.vehicleManufacturerAndType = dict["vehicleManufacturerAndType"] as? String ?? ""
        driver.vehicleYearOfManufacture = dict["vehicleYearOfManufacture"] as? String ?? ""
        driver.vehicleStateRegistrationPlate = dict["vehicleStateRegistrationPlate"] as? String ?? ""
        driver.insurer = dict["insurer"] as? String ?? ""
        driver.insurerBranchAddress = dict["insurerBranchAddress"] as? String ?? ""
        driver.insuranceNumber = dict["insuranceNumber"] as? String ?? ""
        driver.greenCardNumber = dict["greenCardNumber"] as? String ?? ""
        
        if let timestamp = dict["borderInsuranceValidUntil"] as? TimeInterval {
            driver.borderInsuranceValidUntil = Date(timeIntervalSince1970: timestamp)
        }
        
        driver.comprehensiveInsurance = dict["comprehensiveInsurance"] as? Bool ?? false
        driver.comprehensiveInsuranceCompany = dict["comprehensiveInsuranceCompany"] as? String ?? ""
        driver.surnameOfDriver = dict["surnameOfDriver"] as? String ?? ""
        driver.firstNameOfDriver = dict["firstNameOfDriver"] as? String ?? ""
        driver.addressOfDriver = dict["addressOfDriver"] as? String ?? ""
        driver.phoneNumberOfDriver = dict["phoneNumberOfDriver"] as? String ?? ""
        driver.driverLicenseNumber = dict["driverLicenseNumber"] as? String ?? ""
        driver.categoryOfLicense = dict["categoryOfLicense"] as? String ?? ""
        driver.licenseIssuedBy = dict["licenseIssuedBy"] as? String ?? ""
        
        return driver
    }
}
