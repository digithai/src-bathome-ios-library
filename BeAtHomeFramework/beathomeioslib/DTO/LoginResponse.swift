//
//  LoginResponse.swift
//  beathomeioslib
//
//  Created by Marco on 7/11/19.
//  Copyright © 2019 DIGITHAI Software Group. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    var ErrorCode: String
    var ErrorDescription: String
    var data: String
}

struct ResponseURL: Codable {
    var public_url: String
    var private_url: String
}
