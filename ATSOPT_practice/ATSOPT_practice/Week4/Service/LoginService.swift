//
//  LoginService.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 5/9/25.
//

import Foundation

final class LoginService {
    static let shared = LoginService()
    private init() { }
    
    func makeRequestBody(userID: String, password: String) -> Data? {
        do {
            let data = LoginRequest(
                loginId: userID,
                password: password
            )
            let jsonEncoder = JSONEncoder()
            let requestBody = try jsonEncoder.encode(data)
            
            return requestBody
        } catch {
            print(error)
            return nil
        }
    }
    
    func makeRequest(body: Data?) -> URLRequest? {
        let url = URL(string: "http://api.atsopt-seminar4.site/api/v1/auth/signin")!
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
    
    func login(userID: String, password: String) async throws -> Int {
        guard let body = makeRequestBody(userID: userID, password: password)
        else { throw NetworkError.requestEncodingError }
        
        let request = self.makeRequest(body: body)!
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse
        else { throw NetworkError.responseError }
        dump(response)
        
        guard (200...299).contains(httpResponse.statusCode)
        else { throw configureHTTPError(errorCode: httpResponse.statusCode) }
        
        do {
            let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
            return decoded.data.userId
        } catch {
            throw NetworkError.responseDecodingError
        }
    }
}
