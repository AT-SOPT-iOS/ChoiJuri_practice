//
//  SignupResponse.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 5/3/25.
//

import Foundation

struct SignupResponse: Decodable {
    let success: Bool
    let code: String
    let message: String
    let data: SignupResponseData
}

extension SignupResponse {
    struct SignupResponseData: Decodable {
        let userId: Int
        let nickname: String
    }
}
