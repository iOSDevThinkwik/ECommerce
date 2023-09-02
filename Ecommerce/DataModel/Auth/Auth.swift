//
//  Auth.swift
//  Fenix
//
//  Created by shotDeck_developer  on 28/12/21.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let success: Bool?
    let message: String?
    let data: DataToken?
}

// MARK: - DataClass
struct DataToken: Codable {
    let token: String?
}

// MARK: - ForgotPasswordResponse
struct ForgotPasswordResponse: Codable {
    let success: Bool?
    let message: String?
}

// MARK: - CreateSignupCode
struct CreateSignupCodeResponse: Codable {
    let success: Bool?
    let message: String?
}

// MARK: - VerifySignupCode
struct VerifySignupCodeResponse: Codable {
    let success: Bool?
    let message: String?
}

// MARK: - SignupResponse
struct SignupResponse: Codable {
    let success: Bool?
    let message: String?
    let data: signupFinal?
}

// MARK: - DataClass
struct signupFinal: Codable {
    let userid: Int?
    let token: String?
}

// MARK: - User/Me/Account info
struct ProfileResponse: Codable {
    let success: Bool
    let message: String
    let data: User
}

// MARK: - DataClass
struct User: Codable {
    
    let email, firstName, lastName, subscriptionStatus: String?
    let subscriptionEnd: String?
    let excludeNudity: Bool?
    
    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case subscriptionStatus = "subscription_status"
        case subscriptionEnd = "subscription_end"
        case excludeNudity = "exclude_nudity"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.subscriptionStatus = try container.decodeIfPresent(String.self, forKey: .subscriptionStatus)
        self.subscriptionEnd = try container.decodeIfPresent(String.self, forKey: .subscriptionEnd)
        do {
            let excludeNudity = try container.decodeIfPresent(String.self, forKey: .excludeNudity)
            self.excludeNudity = (excludeNudity?.lowercased() == "true") ? true : false
        }
        catch {
            let excludeNudity = try container.decodeIfPresent(Bool.self, forKey: .excludeNudity)
            self.excludeNudity = excludeNudity
        }
        
    }
    
    
}
