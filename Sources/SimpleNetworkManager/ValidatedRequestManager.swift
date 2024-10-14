//
//  ValidatedRequestManager.swift
//
//
//  Created by Bradley Windybank on 26/09/23.
//

import Alamofire
import Foundation

public protocol ValidatedRequestManager: Sendable {
    /** Make an async, throwing request to an `endpoint` with an `apiKey` and `parameters`, returns response of `NonNullableResult`, useful for safe handling of API responses with nullable properties. */
    func makeRequest<ResponseType: NonNullableResult>(
        endpoint: String,
        parameters: [String: Sendable]?,
        validContentTypes: [String],
        decoder: DataDecoder
    ) async throws -> ResponseType

    func applyAuth(headers: HTTPHeaders?, parameters: [String: Sendable]?) -> (HTTPHeaders?, [String: Sendable]?)
}

/// Wrappers around common content types
public extension ValidatedRequestManager {
    func makeJsonRequest<ResponseType: NonNullableResult>(endpoint: String, parameters: [String: Sendable]?) async throws -> ResponseType {
        try await makeRequest(endpoint: endpoint, parameters: parameters, validContentTypes: ["application/json"], decoder: JSONDecoder())
    }
}
