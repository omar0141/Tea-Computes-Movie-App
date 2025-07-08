//
//  HttpModels.swift
//  movie-app
//
//  Created by Omar on 07/07/2025.
//

struct HttpRequestModel {
    let url: String
    let method: Method
    let headers: [String: String]?
    let body: [String: Any]?
    
    init(
        url: String,
        method: Method,
        headers: [String: String]? = nil,
        body: [String: Any]? = nil,
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}


struct HttpResponseModel {
    let statusCode: Int
    let type: String?
    let message: String?
    let data: [String: Any]?
    
    init(
        statusCode: Int,
        type: String? = nil,
        message: String? = nil,
        data: [String: Any]? = nil
    ) {
        self.statusCode = statusCode
        self.type = type
        self.message = message
        self.data = data
    }
}
