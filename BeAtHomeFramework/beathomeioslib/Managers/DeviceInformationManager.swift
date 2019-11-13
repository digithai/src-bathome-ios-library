//
//  DeviceInformationManager.swift
//  beathomeioslib
//
//  Created by Marco on 8/11/19.
//  Copyright © 2019 DIGITHAI Software Group. All rights reserved.
//

import Foundation
import UIKit

public class DeviceInformationManager {
    
    public static func getDeviceID() -> String {
        UIDevice.current.identifierForVendor!.uuidString
    }
    
    public static func gedDeviceType() -> String {
        UIDevice.current.modelName
    }
}

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}
