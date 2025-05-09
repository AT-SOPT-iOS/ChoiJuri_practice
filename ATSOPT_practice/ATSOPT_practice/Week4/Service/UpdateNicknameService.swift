//
//  UpdateNicknameService.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 5/9/25.
//

import Foundation

final class UpdateNicknameService {
    static let shared = UpdateNicknameService()
    private init() { }
    
    func makeRequestBody(nickName: String) -> Data? {
        do {
            let data = PatchNicknameRequest(nickname: nickName)
            let jsonEncoder = JSONEncoder()
            let requestBody = try jsonEncoder.encode(data)
            
            return requestBody
        } catch {
            print(error)
            return nil
        }
    }
    
    func makeRequest(body: Data?, userID: Int) -> URLRequest? {
        let url = URL(string: "http://api.atsopt-seminar4.site/api/v1/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(userID)", forHTTPHeaderField: "userId")
        
        if let body {
            request.httpBody = body
        }
        
        return request
    }
    
    func updateNickname(userID: Int, nickname: String) async throws -> Bool {
        guard let body = makeRequestBody(nickName: nickname)
        else { throw NetworkError.requestEncodingError }
        
        let request = self.makeRequest(body: body, userID: userID)!
        dump(request)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse
        else { throw NetworkError.responseError }
        dump(response)
        
        guard (200...299).contains(httpResponse.statusCode)
        else{ throw configureHTTPError(errorCode: httpResponse.statusCode) }
        dump(request)

        do {
            let decoded = try JSONDecoder().decode(PatchNicknameResponse.self, from: data)
            return decoded.success
        } catch {
            throw NetworkError.responseDecodingError
        }
    }
}
