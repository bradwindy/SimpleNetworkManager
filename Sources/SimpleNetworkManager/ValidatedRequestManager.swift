//
//  ValidatedRequestManager.swift
//  WidgetMe
//
//  Created by Bradley Windybank on 26/09/23.
//

import Alamofire
import Foundation

public protocol ValidatedRequestManager {
    /** Make an async, throwing request to an `endpoint` with an `apiKey` and `parameters`, returns response of `NonNullableResult`, useful for safe handling of API responses with nullable properties. */
    func makeRequest<ResponseType: NonNullableResult>(endpoint: String, parameters: inout [String: Any]?) async throws -> ResponseType

    func applyAuth(headers: inout HTTPHeaders?, parameters: inout [String: Any]?)

    /// A closure used for validating the network response
    var validation: (URLRequest?, HTTPURLResponse, Data?) -> Result<Void, Error> { get }
}
