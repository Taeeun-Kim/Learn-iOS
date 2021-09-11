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
