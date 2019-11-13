//
//  TokenResponse.swift
//  beathomeioslib
//
//  Created by Marco on 7/11/19.
//  Copyright © 2019 DIGITHAI Software Group. All rights reserved.
//

import Foundation

struct TokenResponse: Codable {
    var ErrorCode: String
    var ErrorDescription: String
    var token: String
}
