//
//  WebError.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public class WebError: Error {
    
    // MARK: - Nested Types
    
    public enum Code {
        
        // MARK: - Enumeration Cases
        
        case unknown
        case aborted
        
        case tooManyRequests

        case connection
        case timeOut
        
        case security
        
        case badRequest
        case badResponse
        
        case unauthorized
        
        case resource
        case server
        case access
    }
    
    // MARK: - Type Properties
    
    public static let unknown = WebError(code: .unknown)
    public static let aborted = WebError(code: .aborted)
    
    public static let tooManyRequests = WebError(code: .tooManyRequests)
    
    public static let connection = WebError(code: .connection)
    public static let timeOut = WebError(code: .timeOut)
    
    public static let security = WebError(code: .security)
    
    public static let badRequest = WebError(code: .badRequest)
    public static let badResponse = WebError(code: .badResponse)
    
    public static let unauthorized = WebError(code: .unauthorized)
    
    public static let resource = WebError(code: .resource)
    public static let server = WebError(code: .server)
    public static let access = WebError(code: .access)
    
    // MARK: - Instance Properties
    
    public final let code: Code
    
    public final let base: WebErrorBase?
    public final let data: Any?
    
    // MARK: -
    
    public var logDescription: String {
        var description: String
        
        switch self {
        case WebError.aborted:
            description = "WebError.aborted"
            
        case WebError.tooManyRequests:
            description = "WebError.tooManyRequests"
            
        case WebError.connection:
            description = "WebError.connection"
            
        case WebError.timeOut:
            description = "WebError.timeOut"
            
        case WebError.security:
            description = "WebError.security"
            
        case WebError.badRequest:
            description = "WebError.badRequest"
            
        case WebError.badResponse:
            description = "WebError.badResponse"
            
        case WebError.unauthorized:
            description = "WebError.unauthorized"
            
        case WebError.resource:
            description = "WebError.resource"
            
        case WebError.server:
            description = "WebError.server"
            
        case WebError.access:
            description = "WebError.access"
            
        default:
            description = "WebError.unknown"
        }
        
        if let base = self.base {
            if let data = self.data {
                description.append("(\(base.logDescription), data: \(data)")
            } else {
                description.append("(\(base.logDescription))")
            }
        }
        
        return description
    }
    
    public final var statusCode: Int? {
        return (self.base as? WebStatusCode)?.rawValue
    }
    
    // MARK: - Initializers
    
    public init(code: Code, base: WebErrorBase? = nil, data: Any? = nil) {
        self.code = code
        
        self.base = base
        self.data = data
    }
    
    public convenience init?(fromStatusCode statusCode: Int, data: Any?) {
        guard statusCode >= 400 else {
            return nil
        }
        
        switch statusCode {
        case 429:
            self.init(code: .tooManyRequests, base: WebStatusCode(rawValue: statusCode), data: data)
            
        case 511:
            self.init(code: .connection, base: WebStatusCode(rawValue: statusCode), data: data)
            
        case 408,
             504:
            self.init(code: .timeOut, base: WebStatusCode(rawValue: statusCode), data: data)
            
        case 400,
             406,
             411,
             412,
             413,
             414,
             415,
             416,
             417,
             422,
             425,
             426,
             428,
             431,
             449:
            self.init(code: .badRequest, base: WebStatusCode(rawValue: statusCode), data: data)
            
        case 401:
            self.init(code: .unauthorized, base: WebStatusCode(rawValue: statusCode), data: data)
            
        case 404,
             405,
             409,
             410,
             423,
             434:
            self.init(code: .resource, base: WebStatusCode(rawValue: statusCode), data: data)
            
        case 424,
             444,
             500,
             501,
             502,
             503,
             505,
             506,
             507,
             508,
             509,
             510:
            self.init(code: .server, base: WebStatusCode(rawValue: statusCode), data: data)
            
        case 402,
             403,
             407,
             451:
            self.init(code: .access, base: WebStatusCode(rawValue: statusCode), data: data)
            
        default:
            self.init(code: .unknown, base: WebStatusCode(rawValue: statusCode), data: data)
        }
    }
    
    public convenience init(fromURLError error: URLError, data: Any?) {
        switch error.code {
        case .cancelled:
            self.init(code: .aborted, base: error, data: data)
            
        case .cannotLoadFromNetwork,
             .cannotFindHost,
             .dnsLookupFailed,
             .internationalRoamingOff,
             .networkConnectionLost,
             .notConnectedToInternet,
             .backgroundSessionInUseByAnotherProcess,
             .backgroundSessionRequiresSharedContainer,
             .backgroundSessionWasDisconnected,
             .secureConnectionFailed:
            self.init(code: .connection, base: error, data: data)
            
        case .httpTooManyRedirects,
             .timedOut:
            self.init(code: .timeOut, base: error, data: data)
            
        case .appTransportSecurityRequiresSecureConnection,
             .clientCertificateRejected,
             .clientCertificateRequired,
             .serverCertificateHasBadDate,
             .serverCertificateHasUnknownRoot,
             .serverCertificateNotYetValid,
             .serverCertificateUntrusted:
            self.init(code: .security, base: error, data: data)
            
        case .unsupportedURL,
             .badURL:
            self.init(code: .badRequest, base: error, data: data)
            
        case .badServerResponse,
             .cannotParseResponse,
             .downloadDecodingFailedMidStream,
             .downloadDecodingFailedToComplete:
            self.init(code: .badResponse, base: error, data: data)
            
        case .redirectToNonExistentLocation,
             .cannotDecodeContentData,
             .cannotDecodeRawData,
             .resourceUnavailable,
             .zeroByteResource,
             .dataLengthExceedsMaximum:
            self.init(code: .resource, base: error, data: data)
            
        case .cannotConnectToHost:
            self.init(code: .server, base: error, data: data)
            
        case .dataNotAllowed,
             .noPermissionsToReadFile,
             .userAuthenticationRequired,
             .userCancelledAuthentication:
            self.init(code: .access, base: error, data: data)
            
        case .callIsActive,
             .cannotCloseFile,
             .cannotCreateFile,
             .cannotMoveFile,
             .cannotOpenFile,
             .cannotRemoveFile,
             .cannotWriteToFile,
             .fileDoesNotExist,
             .fileIsDirectory,
             .requestBodyStreamExhausted,
             .unknown:
            self.init(code: .unknown, base: error, data: data)
            
        default:
            self.init(code: .unknown, base: error, data: data)
        }
    }
}

// MARK: - Equatable

extension WebError: Equatable {
    
    // MARK: - Type Methods
    
    public static func == (left: WebError, right: WebError) -> Bool {
        return (left.code == right.code)
    }
    
    public static func != (left: WebError, right: WebError) -> Bool {
        return (left.code != right.code)
    }
    
    public static func ~= (left: WebError, right: WebError) -> Bool {
        return (left.code == right.code)
    }
}
