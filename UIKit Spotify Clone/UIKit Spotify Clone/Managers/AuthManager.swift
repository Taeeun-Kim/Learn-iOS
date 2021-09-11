//
//  AuthManager.swift
//  UIKit Spotify Clone
//
//  Created by Taeeun Kim on 19.08.21.
//

import Foundation

final class AuthManager {
    // Singleton
    static let shared = AuthManager()
    
    struct Constants {
        static let clientId = "4d03d8b9b0024330aac97bb97cccb041"
        static let clientSecret = "6e4b80c9c2a443cab935c59fe4560c42"
    }
    
    private init() {}
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String?  {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
}
