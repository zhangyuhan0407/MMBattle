//
//  MMStuff.swift
//  MechanMon
//
//  Created by yuhan zhang on 9/20/16.
//
//

import Foundation


protocol MMUnitFlow {
    
    func willHit(character: MMUnit)
    
    func willBehit(character: MMUnit)
    
    func didBehit(character: MMUnit, damage: MMDamage)
    
    func didHit(character: MMUnit, damage: MMDamage)
}


extension MMUnitFlow {
    
    func willHit(character: MMUnit) { }
    
    func willBehit(character: MMUnit) { }
    
    func didBehit(character: MMUnit, damage: MMDamage) { }
    
    func didHit(character: MMUnit, damage: MMDamage) { }
}




protocol MMUnitObservable {
    func onHPChanged(character: MMUnit, newValue: inout Int, oldValue: Int)
}






