//
//  NicknameListResponse.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 5/3/25.
//

import Foundation

struct NicknameListResponse: Decodable {
    let success: Bool
    let code: String
    let message: String
    let data: NicknameListRespnoseData
}

extension NicknameListResponse {
    struct NicknameListRespnoseData: Decodable {
        let nicknameList: [String]
    }
}
