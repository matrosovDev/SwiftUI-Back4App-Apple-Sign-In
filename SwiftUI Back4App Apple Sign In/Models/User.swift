//
//  User.swift
//  EasyFitJustTryIt-SwiftUI
//
//  Created by Oleksandr Matrosov on 25/11/24.
//

import Foundation
import ParseSwift

struct User: ParseUser {
    
    var emailVerified: Bool?
    var password: String?
    var authData: [String : [String : String]?]?
    var originalData: Data?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseSwift.ParseACL?
    
    var objectId: String?
    var username: String?
    var email: String?
    var sessionToken: String?
    var firstName: String?
    var lastName: String?
}
