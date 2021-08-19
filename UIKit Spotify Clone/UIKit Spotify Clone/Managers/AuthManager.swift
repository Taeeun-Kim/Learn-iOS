//
//  AuthManager.swift
//  UIKit Spotify Clone
//
//  Created by Taeeun Kim on 19.08.21.
//

import Foundation

final class AuthManager {
    // AuthManager().isSignedIn으로도 사용 가능
    // 하지만 "'AuthManager' initializer is inaccessible due to 'private' protection level"
    // 그렇기에 shared를 이용해서 접근
    static let shared = AuthManager()
    
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
