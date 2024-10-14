//
//  NetworkRequestManager.swift
//
//
//  Created by Bradley Windybank on 26/09/23.
//

import Alamofire
import Foundation

public final class NetworkRequestManager: ValidatedRequestManager {
    // MARK: Lifecycle

    public init() {}

    // MARK: Public

    public func makeRequest<ResponseType: NonNullableResult>(
        endpoint: String,
        parameters: [String: Sendable]?,
        validContentTypes: [String] = ["application/json"],
        decoder: DataDecoder = JSONDecoder()
    )
        async throws -> ResponseType
    {
        let (_, newParameters) = applyAuth(headers: nil, parameters: parameters)

        let request = AF.request(endpoint, parameters: newParameters, headers: nil)

        let result = await request
            .validate()
            .validate(contentType: validContentTypes)
            .serializingDecodable(ResponseType.self, decoder: decoder)
            .result

        switch result {
        case let .success(value):
            return value

        case let .failure(error):
            throw error
        }
    }

    public func applyAuth(headers: HTTPHeaders?, parameters: [String: Sendable]?) -> (HTTPHeaders?, [String: Sendable]?) {
        (headers, parameters)
    }
}
