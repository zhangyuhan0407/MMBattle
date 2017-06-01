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
    
    func willBehit(character: MMUnit, skill: BTSkill)
    
    func didBehit(character: MMUnit, skill: BTSkill, damage: MMDamage)
    
    func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage])
}






protocol MMUnitObservable {
    var observerKey: String { get set }
    func onHPChanged(character: MMUnit, newValue: inout Int, oldValue: Int)
}






