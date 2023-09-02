//
//  AuthBean.swift
//  NSUrlSession+RequestBuilder
//
//  Created by shotDeck_developer  on 16/12/21.
//

import Foundation

// Login with Email Request
struct LoginRequest: Codable {
    let email, password: String
}

// Singup code Request
struct CreateSingupCodeRequest: Codable {
    let email: String?
}

// Verify Singup code Request
struct VerifySignupCodeRequest: Codable{
    let confirmation_code: String?
}

// Singup Request
struct SignupRequest: Codable{
    let first_name,last_name,email,password: String?
    let password_confirm,industry,industry_job,industry_where: String?
    let website: String?
    let email_opt_in: String?
    let confirmation_code: String?
}

// Forgot password Request
struct ForgotPasswordRequest: Codable {
    let email: String?
}

// MARK: - GetJobCategoryResponse
struct GetJobCategoryResponse: Codable {
    let success: Bool?
    let message: String?
    let data: [GetJobCategoryData]
}

// MARK: - GetJobCategory Data
struct GetJobCategoryData: Codable {
    
    let advertising, studentEducation, filmTVProduction, commercialMusicVideoProduction: [String]
    let gamingIndustry, photography, design, executiveDevelopment: [String]
    let publishingBlogsMagazines, other: [String]

    enum CodingKeys: String, CodingKey {
        case advertising = "Advertising"
        case studentEducation = "Student / Education"
        case filmTVProduction = "Film / TV Production"
        case commercialMusicVideoProduction = "Commercial / Music Video Production"
        case gamingIndustry = "Gaming Industry"
        case photography = "Photography"
        case design = "Design"
        case executiveDevelopment = "Executive / Development"
        case publishingBlogsMagazines = "Publishing / Blogs / Magazines"
        case other = "Other"
    }
    
}
