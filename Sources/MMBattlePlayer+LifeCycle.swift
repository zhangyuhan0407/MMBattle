//
//  MMQingNiao.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation


extension MMBattlePlayer {
    
    
    func act() {
        guard let char = self.nextAliveCharacter else {
            return
        }

        
        self.record.putFightLog(log: BTFightLog(unit: char))
        
        char.willHit()
        
        let skill = char.createSkill()
        self.record.putSkill(skill: skill)
        
        if skill.index == 0 {
            return
        }
        
        
        let mainDamage = char.createMainTargetDamage(skill: skill)
        
        if mainDamage != nil {
            let mainTarget = mainDamage!.destination!
            mainTarget.willBehit(skill: skill)
            char.hit(skill: skill, damage: mainDamage!)
            mainTarget.behit(skill: skill, damage: mainDamage!)
            mainTarget.didBehit(skill: skill, damage: mainDamage!)
            self.record.putMainDamage(damage: mainDamage!)
        }
        
        
        let sideDamages = char.createSideTargetDamages(skill: skill)
        
        for damage in sideDamages {
            let target = damage.destination!
            target.behit(skill: skill, damage: damage)
            target.didBehit(skill: skill, damage: damage)
        }
        
        
        char.didHit(skill: skill, mainDamage: mainDamage, sideDamages: sideDamages)
        
        self.record.putSideDamages(damages: sideDamages)
        
        
        self.record.pushFightLog()
        
    }
    

}


