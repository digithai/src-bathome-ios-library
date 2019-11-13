//
//  TokenRequest.swift
//  beathomeioslib
//
//  Created by Marco on 8/11/19.
//  Copyright © 2019 DIGITHAI Software Group. All rights reserved.
//

import Foundation

struct TokenRequest: Codable {
    var username: String
    var projectcode: String
    var deviceId: String
}
