//
//  EncrypterUtil.swift
//  beathomeioslib
//
//  Created by Marco on 6/11/19.
//  Copyright © 2019 DIGITHAI Software Group. All rights reserved.
//

import Foundation

public class EncrypterUtil {
    
    let encryptKey = Configs.encryptionKey
    
    /**
     Encrypts the passed string using an hard coded encryption key
    
        - returns: The encrypted string or nil
        - parameter stringToEncrypt: The string to be encrypted
    
     */
    public func encrypt(stringToEncrypt: String) -> String? {
        
        if stringToEncrypt == "" {
            print("String to encrypt cannot be empty")
            return nil
        }
        
        return encrypt(stringToEncrypt: stringToEncrypt, encKey: encryptKey)
    }
    
    /**
     Encrypts the passed string using an encryption key
    
        - returns: The encrypted string or nil
        - parameter stringToEncrypt: The string to be encrypted
        - parameter encKey: The encryption key
    
     */
    public func encrypt(stringToEncrypt: String, encKey: String) -> String? {
        
        if stringToEncrypt == "" ||  encKey == "" {
            print("String to encrypt cannot be empty")
            return nil
        }
        
        var encrypted: [UInt8] = []
        
        do {
            encrypted = try AES(key: encKey, iv: encKey).encrypt([UInt8](stringToEncrypt.data(using: .utf8)!))
        }
        catch{
            print("Error occurred while encrypting the data: \(error).")
        }
        
        return Data(encrypted).base64EncodedString()
    }
    
    /**
        Decrypts the passed string using an hard coded decryption key
       
           - returns: The decrypted string or nil
           - parameter stringToDecrypt: The string to be decrypted
        
        */
    
    public func decrypt(stringToDecrypt: String) -> String? {
        
        if stringToDecrypt == "" {
            print("String to decrypt cannot be empty")
            return nil
        }
        
        return decrypt(stringToDecrypt: stringToDecrypt, decKey: encryptKey)
    }

    /**
     Decrypts the passed string using a decryption key
    
        - returns: The decrypted string or nil
        - parameter stringToDecrypt: The string to be decrypted
        - parameter decKey: The decryption key
     
     */
    public func decrypt(stringToDecrypt: String, decKey: String) -> String? {
        
        if stringToDecrypt == "" || decKey == "" {
            print("String to decrypt cannot be empty")
            return nil
        }
        
        guard let data = Data(base64Encoded: stringToDecrypt) else {
            return nil
        }
        
        do {
            let decrypted = try AES(key: decKey, iv: decKey).decrypt([UInt8](data))
            let data = Data(bytes: decrypted, count: decrypted.count)
            
            if let string = String(data: data, encoding: .utf8) {
                return string
            } else {
                print("not a valid UTF-8 sequence")
                return nil
            }
        }
        catch {
            print("Error occurred while decrypting the data: \(error).")
            return nil
        }
    }
}
