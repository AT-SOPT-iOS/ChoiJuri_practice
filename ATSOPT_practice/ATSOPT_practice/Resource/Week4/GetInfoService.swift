//
//  GetInfoService.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 5/3/25.
//

import Foundation

final class GetInfoService {
    static let shared = GetInfoService()
    private init() { }
    
    func makeRequest(keyword: String?, userId: Int) -> URLRequest? {
        var urlString = "http://api.atsopt-seminar4.site/api/v1/users"
        
        if let keyword,
           !keyword.isEmpty {
            if let encoded = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                urlString += "?keyword=\(encoded)"
            }
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func fetchNicknameList(keyword: String?, userId: Int) async throws -> [String] {
        guard let request = makeRequest(keyword: keyword, userId: userId) else {
            throw NetworkError.requestEncodingError
        }
        dump(request)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else { throw NetworkError.responseError }
        dump(response)
        do {
            let decoded = try JSONDecoder().decode(NicknameListResponse.self, from: data)
            return decoded.data.nicknameList
        } catch {
            throw NetworkError.responseDecodingError
        }
    }
}
