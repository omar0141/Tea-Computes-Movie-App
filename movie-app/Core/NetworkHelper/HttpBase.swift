//
//  HttpBase.swift
//  movie-app
//
//  Created by Omar on 07/07/2025.
//

import Foundation

enum ContentType {
    case json
    case formData
}

class HttpBase {
    
    static let shared = HttpBase()
    
    private init() {}
    
    func call<T: Decodable>(
        _ model: HttpRequestModel,
        contentType: ContentType = .formData,
        responseType: T.Type
    ) async throws -> T {
        guard let url = URL(string: model.url) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = model.headers
        request.httpMethod = model.method.rawValue
        if model.method != .get {
            switch contentType {
            case .json:
                request.setValue(
                    "application/json",
                    forHTTPHeaderField: "Content-Type"
                )
                request.httpBody = try? JSONSerialization.data(
                    withJSONObject: model.body ?? [:]
                )

            case .formData:
                let boundary = "Boundary-\(UUID().uuidString)"
                request.setValue(
                    "multipart/form-data; boundary=\(boundary)",
                    forHTTPHeaderField: "Content-Type"
                )
                request.httpBody = createFormData(
                    from: model.body ?? [:],
                    boundary: boundary
                )
            }
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
            200..<300 ~= httpResponse.statusCode
        else {
            let message = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(
                domain: "",
                code: (response as? HTTPURLResponse)?.statusCode ?? 500,
                userInfo: [NSLocalizedDescriptionKey: message]
            )
        }

        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }

    private func createFormData(
        from dictionary: [String: Any],
        boundary: String
    ) -> Data {
        var formData = Data()

        for (key, value) in dictionary {
            formData.append("--\(boundary)\r\n".data(using: .utf8)!)
            if let fileData = value as? Data {
                formData.append(
                    "Content-Disposition: form-data; name=\"\(key)\"; filename=\"file\"\r\n"
                        .data(using: .utf8)!
                )
                formData.append(
                    "Content-Type: application/octet-stream\r\n\r\n".data(
                        using: .utf8
                    )!
                )
                formData.append(fileData)
            } else {
                formData.append(
                    "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n"
                        .data(using: .utf8)!
                )
                formData.append("\(value)".data(using: .utf8)!)
            }
            formData.append("\r\n".data(using: .utf8)!)
        }

        formData.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return formData
    }
}
