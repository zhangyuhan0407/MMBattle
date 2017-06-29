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

        //char初始状态
        self.record.putFightLog(log: BTFightLog(unit: char))
        
        
        //char before状态
        char.willHit()
        
        
        
        let skill = char.createSkill()
        self.record.putSkill(skill: skill)
        
        
        
        //跳过所有hit
        if skill.index == 0 {
//            char.didHit(skill: skill, mainDamage: nil, sideDamages: [])
            self.record.pushFightLog()
            return
        }
        
        
        //char mainDamage后状态
        let mainDamage = char.createMainTargetDamage(skill: skill)
        if mainDamage != nil {
            let mainTarget = mainDamage!.destination!
            mainTarget.willBehit(skill: skill)
            char.hit(skill: skill, damage: mainDamage!)
            mainTarget.behit(skill: skill, damage: mainDamage!)
            mainTarget.didBehit(skill: skill, damage: mainDamage!)
            char.card.valueHandler(character: char, skill: skill, damage: mainDamage!)
            mainDamage?.pin()
            self.record.putMainDamage(damage: mainDamage!)
        }
        
        
        //char sideDamage后状态
        let sideDamages = char.createSideTargetDamages(skill: skill)
        for damage in sideDamages {
            let target = damage.destination!
            char.hit(skill: skill, damage: damage)
            target.behit(skill: skill, damage: damage)
            target.didBehit(skill: skill, damage: damage)
            char.card.valueHandler(character: char, skill: skill, damage: damage)
            damage.pin()
        }
        self.record.putSideDamages(damages: sideDamages)
        
        
        //char didhit后状态
        char.didHit(skill: skill, mainDamage: mainDamage, sideDamages: sideDamages)
        
        self.record.pushFightLog()
        
    }
    

}


