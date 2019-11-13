//
//  beathomeioslib.swift
//  beathomeioslib
//
//  Created by Marco on 6/11/19.
//  Copyright © 2019 DIGITHAI Software Group. All rights reserved.
//
import Foundation

public class BeAtHomeIOSLib {
    
    private struct LibErrors {
        static let emptyUsername = "Username cannot be empty"
        static let emptyPassword = "Password cannot be empty"
        static let emptyProjectCode = "Project code cannot be empty"
        static let errorToken = "Error while fetching the token "
        static let errorDecodingJsonUrls = "Error decoding json for response urls: "
        static let loginError = "Error while logging in: "
        static let unknownError = "Unknown error while logging in"
    }
    
    public init(){}
    /**
    Authenticates to BeAtHome
    - Parameter username: User name of the user
    - Parameter password: Password of the user
    - Parameter projectCode: Current project code of the user
    - Parameter completionHandler: The callback called after retrieval
    - Parameter result: An optional dictionary with the following keys: errorCode - errorDescription - publicURL - privateURL
    - Parameter error: An optional String reporting an error
    */
    public func authenticate(username: String, password: String, projectCode: String, completionHandler: @escaping (_ result: [String:Any]?, _ error: String?) -> Void ) {
        
        if username == "" {
            completionHandler(nil, LibErrors.emptyUsername)
            return
        }
        
        if password == "" {
            completionHandler(nil, LibErrors.emptyPassword)
            return
        }
        
        if projectCode == "" {
            completionHandler(nil, LibErrors.emptyProjectCode)
            return
        }
        
        LoginClient().getToken(username: username, projectCode: projectCode, completion: {
            result in
            
            switch result {
            case .success(let tokenResults):
                guard let token = tokenResults?.token else {
                    completionHandler(nil, LibErrors.errorToken)
                    return
                }
                
                if token != "" {
                    LoginClient().login(username: username, password: password, projectCode: projectCode, encryptionKey:token, completion: {
                        response in
                        
                        switch response{
                        case .success(let loginResult):
                            guard let data = loginResult?.data else {
                                completionHandler(nil, LibErrors.unknownError)
                                return
                            }
                            
                            var responseURLs = ResponseURL(public_url: "", private_url: "")
                            
                            if data != "" {
                                guard let decryptedData = EncrypterUtil().decrypt(stringToDecrypt: data, decKey: token) else { return }
                                
                                do {
                                    responseURLs = try JSONDecoder().decode(ResponseURL.self, from: decryptedData.data(using: .utf8)!)
                                } catch {
                                    print(LibErrors.errorDecodingJsonUrls + error.localizedDescription)
                                    completionHandler(nil, LibErrors.errorDecodingJsonUrls + error.localizedDescription)
                                }
                            }
                            
                            let resultDTO:[String:Any] =  [
                                "errorCode": loginResult?.ErrorCode ?? "",
                                "errorDescription": loginResult?.ErrorDescription ?? "",
                                "privateURL":responseURLs.private_url,
                                "publicURL":responseURLs.public_url
                            ]
                            
                            completionHandler(resultDTO, nil)
                            
                        case .failure(let error):
                            print(LibErrors.loginError + error.localizedDescription)
                            completionHandler(nil, LibErrors.loginError + error.localizedDescription)
                        }
                    })
                }
                else {
                    let resultDTO:[String:Any] =  [
                        "errorCode": tokenResults?.ErrorCode ?? "",
                        "errorDescription": tokenResults?.ErrorDescription ?? "",
                        "privateURL":"",
                        "publicURL":""
                    ]
                    completionHandler(resultDTO, nil)
                }
                
            case .failure(let error):
                print(LibErrors.errorToken + error.localizedDescription)
                completionHandler(nil, LibErrors.errorToken + error.localizedDescription)
            }
        })
    }
    
}
