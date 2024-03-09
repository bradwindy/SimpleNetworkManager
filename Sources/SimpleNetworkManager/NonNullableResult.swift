//
//  NonNullableResult.swift
//  WidgetMe
//
//  Created by Bradley Windybank on 26/09/23.
//

import RichError

/**
 A result that can be checked to see if its properties are not null, and throws an error if they are.
 Useful for standardising the way network API responses are handled.
 */
public protocol NonNullableResult: Codable {
    /// Result must provide error type
    associatedtype ErrorType: RichError

    /// Should be used to check to see if properties are not null.
    func checkNonNull() throws -> Self
    func customDescription() -> String
}
