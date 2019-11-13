//
//  LoginClient.swift
//  beathomeioslib
//
//  Created by Marco on 8/11/19.
//  Copyright © 2019 DIGITHAI Software Group. All rights reserved.
//

import Foundation

class LoginClient: APIClient {
    
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    /**
     Fetches the new encryption key to be used when authenticating
    
        - returns: The new encryption key
        - parameter username: Username given by the user
        - parameter projectCode: Project code given by the user
    
     */
    public func getToken(username: String, projectCode: String, completion: @escaping (Result<TokenResponse?, APIError>) -> Void) {
        
        let deviceId = DeviceInformationManager.getDeviceID()
        
        let tokenDTO = TokenRequest(username: username, projectcode: projectCode, deviceId: deviceId)
        
        var json = ""
        
        do {
            let encodedJSON = try JSONEncoder().encode(tokenDTO)
            json = String(data: encodedJSON, encoding: .utf8) ?? ""
        }
        catch {
            completion(Result.failure(.jsonConversionFailure))
        }

        guard let encryptedJSON = EncrypterUtil().encrypt(stringToEncrypt: json) else {
            completion(Result.failure(.genericError))
            return
        }

        let body: [String: Any] = ["data": encryptedJSON]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)

        let url = URL(string: Configs.tokenEndpoint)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
                
        fetch(with: request, decode: {
            json -> TokenResponse? in
            
            guard let tokenResponse = json as? TokenResponse else { return  nil }
            return tokenResponse
            
        }, completion: completion)
    }
    
    public func login(username: String, password:String, projectCode: String, encryptionKey:String, completion: @escaping (Result<LoginResponse?, APIError>) -> Void){
        
        let deviceId = DeviceInformationManager.getDeviceID()
        let deviceType = DeviceInformationManager.gedDeviceType()
        
        let loginDTO = LoginRequest(username: username, password: password, projectCode: projectCode, deviceid: deviceId
            , deviceType: deviceType)
        
        var json = ""
    
        do {
            let encodedJSON = try JSONEncoder().encode(loginDTO)
            json = String(data: encodedJSON, encoding: .utf8) ?? ""
        }
        catch {
            completion(Result.failure(.jsonConversionFailure))
        }

        guard let encryptedJSON = EncrypterUtil().encrypt(stringToEncrypt: json, encKey: encryptionKey) else {
            completion(Result.failure(.genericError))
            return
        }

        let body: [String: Any] = ["data": encryptedJSON]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        let url = URL(string: Configs.authEndpoint)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.setValue(username, forHTTPHeaderField: "username")
        request.httpBody = jsonData

        fetch(with: request, decode: {
            json -> LoginResponse? in
            guard let loginResponse = json as? LoginResponse else { return  nil }
            return loginResponse
            
        }, completion: completion)
    }
}
