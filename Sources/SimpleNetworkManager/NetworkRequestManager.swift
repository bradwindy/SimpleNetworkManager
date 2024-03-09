//
//  NetworkRequestManager.swift
//  WidgetMe
//
//  Created by Bradley Windybank on 26/09/23.
//

import Alamofire
import Foundation

public class NetworkRequestManager: ValidatedRequestManager {
    // MARK: Public

    public var validation: (URLRequest?, HTTPURLResponse, Data?) -> Result<Void, Error> = { request, response, data in
        let acceptableStatusCodes = 200 ..< 300

        let errorData: [String: String] = [
            "request": request?.description ?? "nil request",
            "response": response.description,
            "data": data?.description ?? "nil data",
        ]

        guard acceptableStatusCodes.contains(response.statusCode) else {
            return .failure(NetworkRequestManagerError(kind: .non200StatusCode, data: errorData))
        }

        guard response.mimeType == "application/json" else {
            return .failure(NetworkRequestManagerError(kind: .nonJsonResponse, data: errorData))
        }

        return .success(())
    }

    public func makeRequest<ResponseType: NonNullableResult>(
        endpoint: String,
        parameters: inout [String: Any]?
    )
        async throws -> ResponseType
    {
        var headers: HTTPHeaders? = nil

        applyAuth(headers: &headers, parameters: &parameters)

        let request = AF.request(endpoint, parameters: parameters, headers: headers)

        let result = await request
            .validate(validation)
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
