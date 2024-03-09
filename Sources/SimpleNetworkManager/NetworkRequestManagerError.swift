//
//  File.swift
//  
//
//  Created by Bradley Windybank on 10/03/24.
//

import Foundation
import RichError

public struct NetworkRequestManagerError: RichError {
    public typealias ErrorKind = NetworkRequestManagerErrorKind
    
    public enum NetworkRequestManagerErrorKind: String {
        case non200StatusCode
        case nonJsonResponse
    }
    
    public var kind: NetworkRequestManagerErrorKind
    public var data: [String: String]
}
