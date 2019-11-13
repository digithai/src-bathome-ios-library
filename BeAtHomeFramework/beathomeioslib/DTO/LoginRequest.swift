//
//  LoginRequest.swift
//  beathomeioslib
//
//  Created by Marco on 11/11/19.
//  Copyright © 2019 DIGITHAI Software Group. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    var username: String
    var password: String
    var projectCode: String
    var deviceid: String
    var deviceType: String
}
