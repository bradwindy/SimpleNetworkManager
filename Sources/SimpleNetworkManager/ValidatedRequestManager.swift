//
//  ValidatedRequestManager.swift
//  
//
//  Created by Bradley Windybank on 26/09/23.
//

import Alamofire

public protocol ValidatedRequestManager {
    /** Make an async, throwing request to an `endpoint` with an `apiKey` and `parameters`, returns response of `NonNullableResult`, useful for safe handling of API responses with nullable properties. */
    func makeRequest<ResponseType: NonNullableResult>(endpoint: String, parameters: inout [String: Any]?, validContentTypes: [String]) async throws -> ResponseType

    func applyAuth(headers: inout HTTPHeaders?, parameters: inout [String: Any]?)
}
