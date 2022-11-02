//
//  TokenizableRequestBuilderFactory.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 21..
//

import Foundation

final class TokenizableRequestBuilderFactory: RequestBuilderFactory {
    func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type {
        TokenizableURLSessionRequestBuilder<T>.self
    }

    func getBuilder<T: Decodable>() -> RequestBuilder<T>.Type {
        TokenizableURLSessionDecodableRequestBuilder<T>.self
    }
}

final class TokenizableURLSessionRequestBuilder<T>: URLSessionRequestBuilder<T> {
    override func createURLRequest(urlSession: URLSessionProtocol,
                                   method: HTTPMethod,
                                   encoding: ParameterEncoding,
                                   headers: [String : String]) throws -> URLRequest {
        addToken()
        return try super.createURLRequest(urlSession: urlSession, method: method, encoding: encoding, headers: headers)
    }
}


final class TokenizableURLSessionDecodableRequestBuilder<T: Decodable>: URLSessionDecodableRequestBuilder<T> {
    override func createURLRequest(urlSession: URLSessionProtocol,
                                   method: HTTPMethod,
                                   encoding: ParameterEncoding,
                                   headers: [String : String]) throws -> URLRequest {
        addToken()
        return try super.createURLRequest(urlSession: urlSession, method: method, encoding: encoding, headers: headers)
    }
}
