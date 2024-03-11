//
//  NetworkRequestManager.swift
//
//
//  Created by Bradley Windybank on 26/09/23.
//

import Alamofire
import Foundation

public class NetworkRequestManager: ValidatedRequestManager {
    // MARK: Lifecycle

    public init() {}

    // MARK: Public

    public func makeRequest<ResponseType: NonNullableResult>(
        endpoint: String,
        parameters: inout [String: Any]?,
        validContentTypes: [String] = ["application/json"]
    )
        async throws -> ResponseType
    {
        var headers: HTTPHeaders? = nil

        applyAuth(headers: &headers, parameters: &parameters)

        let request = AF.request(endpoint, parameters: parameters, headers: headers)

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

    public func applyAuth(headers _: inout HTTPHeaders?, parameters _: inout [String: Any]?) {}

    // MARK: Private

    private var decoder = JSONDecoder()
}
