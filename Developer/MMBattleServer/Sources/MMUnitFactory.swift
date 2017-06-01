//
//  MMCharacterRepo.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/5/16.
//
//

import Foundation
import OCTJSON
import OCTFoundation


class MMUnitFactory {
    
    static func createNPCUnit(key: String) -> MMUnit {
        let file = "\(UnitPath)/\(key)"
        
        let json = JSON.read(fromFile: file)!
        
        return MMUnit.deserialize(fromJSON: json)
    }
    
    
}
