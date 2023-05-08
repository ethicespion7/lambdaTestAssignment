//
//  AllowedCredentials.swift
//  shareABite
//
//  Created by chinmay on 08/05/23.
//

import Foundation

class AllowedCredentials: ObservableObject {
    @Published var credentials: [String: String] = [
        "chinmay.tayade@gmail.com": "sid1234",
        "email2@example.com": "password2",
        "chintu@gmail.com":"chintu1234"
        // Add more email-password pairs as needed
    ]
}

