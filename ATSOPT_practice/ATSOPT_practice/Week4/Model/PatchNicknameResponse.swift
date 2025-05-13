//
//  PatchNicknameResponse.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 5/9/25.
//

import Foundation

struct PatchNicknameResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String?
}
