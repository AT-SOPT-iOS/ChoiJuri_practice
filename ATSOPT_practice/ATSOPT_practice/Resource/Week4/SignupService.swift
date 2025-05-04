//
//  SignupService.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 5/3/25.
//

import Foundation

final class SignupService {
    static let shared = SignupService()
    private init() { }
    
    func makeRequestBody(
        loginId: String,
        password: String,
        nickName: String
    ) -> Data? {
        do {
            let data = SignupRequest(
                loginId: loginId,
                password: password,
                nickname: nickName
            )
            let jsonEncoder = JSONEncoder()
            let requestBody = try jsonEncoder.encode(data)
            
            return requestBody
        } catch {
            print(error)
            return nil
        }
    }
    
    func makeRequest(body: Data?) -> URLRequest {
        let url = URL(string: "http://api.atsopt-seminar4.site/api/v1/auth/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let header = ["Content-Type": "application/json"]
        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        if let body {
            request.httpBody = body
        }
        
        return request
    }
    
    func postSignup(
        loginId: String,
        password: String,
        nickName: String
    ) async throws -> SignupResponse.SignupResponseData {
        guard let body = makeRequestBody(loginId: loginId, password: password, nickName: nickName)
        else { throw NetworkError.requestEncodingError }
        
        let request = self.makeRequest(body: body)
        dump(request)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse
        else { throw NetworkError.responseError }
        dump(response)
        
        guard (200...299).contains(httpResponse.statusCode)
        else{ throw configureHTTPError(errorCode: httpResponse.statusCode) }
        
        do {
            let decoded = try JSONDecoder().decode(SignupResponse.self, from: data)
            return decoded.data
        } catch {
            throw NetworkError.responseDecodingError
        }
    }
    
    private func configureHTTPError(errorCode: Int) -> Error {
        return NetworkError(rawValue: errorCode) ?? NetworkError.unknownError
    }
}
