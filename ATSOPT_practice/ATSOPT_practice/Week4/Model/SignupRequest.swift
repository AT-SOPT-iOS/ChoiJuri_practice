//
//  SignupRequest.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 5/3/25.
//

import Foundation

struct SignupRequest: Encodable {
    let loginId: String
    let password: String
    let nickname: String
}
