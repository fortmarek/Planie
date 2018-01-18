//
//  FirebaseErrors.swift
//  TravelPlanner
//
//  Created by Tadeáš Kříž on 06/09/16.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Firebase

enum FirebaseCommonError: Error {
    case networkError
    case userNotFound
    case userTokenExpired
    case tooManyRequests
    case invalidAPIKey
    case appNotAuthorized
    case keychainError
    case internalError
    case unknown

    init(error: NSError) {
        let firebaseError = AuthErrorCode(rawValue: error.code)

        switch firebaseError {
        case .some(AuthErrorCode.networkError):
            self = .networkError
        case .some(AuthErrorCode.userNotFound):
            self = .userNotFound
        case .some(AuthErrorCode.userTokenExpired):
            self = .userTokenExpired
        case .some(AuthErrorCode.tooManyRequests):
            self = .tooManyRequests
        case .some(AuthErrorCode.invalidAPIKey):
            self = .invalidAPIKey
        case .some(AuthErrorCode.appNotAuthorized):
            self = .appNotAuthorized
        case .some(AuthErrorCode.keychainError):
            self = .keychainError
        case .some(AuthErrorCode.internalError):
            self = .internalError
        default:
            self = .unknown
        }
    }
}

enum FirebaseLoginError: Error {
    case common(FirebaseCommonError)
    case operationNotAllowed
    case userDisabled
    case wrongPassword

    init(error: NSError) {
        let firebaseError = AuthErrorCode(rawValue: error.code)

        switch firebaseError {
        case .some(AuthErrorCode.operationNotAllowed):
            self = .operationNotAllowed
        case .some(AuthErrorCode.userDisabled):
            self = .userDisabled
        case .some(AuthErrorCode.wrongPassword):
            self = .wrongPassword
        default:
            self = .common(FirebaseCommonError(error: error))
        }
    }
}

enum FirebaseSignupError: Error {
    case common(FirebaseCommonError)
    case invalidEmail
    case emailAlreadyInUse
    case operationNotAllowed
    case weakPassword(reason: String)

    init(error: NSError) {
        let firebaseError = AuthErrorCode(rawValue: error.code)

        switch firebaseError {
        case .some(AuthErrorCode.invalidEmail):
            self = .invalidEmail
        case .some(AuthErrorCode.emailAlreadyInUse):
            self = .emailAlreadyInUse
        case .some(AuthErrorCode.operationNotAllowed):
            self = .operationNotAllowed
        case .some(AuthErrorCode.weakPassword):
            let reason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String ?? ""
            self = .weakPassword(reason: reason)
        default:
            self = .common(FirebaseCommonError(error: error))
        }
    }
}
