//
//  MMStuff.swift
//  MechanMon
//
//  Created by yuhan zhang on 9/20/16.
//
//

import Foundation


protocol MMCharacterFlow {
    
    func willHit(character: MMCharacter, damage: MMDamage)
    
    func willBehit(character: MMCharacter, damage: MMDamage)
    
    func didBehit(character: MMCharacter, damage: MMDamage)
    
    func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage)
}


extension MMCharacterFlow {
    
    func willHit(character: MMCharacter, damage: MMDamage) { }
    
    func willBehit(character: MMCharacter, damage: MMDamage) { }
    
    func didBehit(character: MMCharacter, damage: MMDamage) { }
    
    func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage) { }
}




protocol MMCharacterObservable {
    func onHPChanged(character: MMCharacter, newValue: inout Int, oldValue: Int)
}






