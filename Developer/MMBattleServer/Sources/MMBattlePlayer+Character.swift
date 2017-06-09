//
//  MMQiongQi.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation
import OCTFoundation



extension MMBattlePlayer {
    
    
    func findCharacter(inCell cell: Int) -> MMUnit? {
        for char in self.characters {
            if char.position == cell && char.hp > 0 {
                return char
            }
        }
        return nil
    }
    
    
    func findCharacters(inCells cells: [Int]) -> [MMUnit] {
        var ret = [MMUnit]()
        for cell in cells {
            for char in self.aliveCharacters {
                if char.position == cell {
                    ret.append(char); break
                }
            }
        }
        return ret
    }
    
    
    func findUnits(forMeleeAttack position: Int) -> MMUnit {
        let sortedCells: [Int]
        switch position {
        case 0,4,8,12:
            sortedCells = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
        case 1,5,9,13:
            sortedCells = [1,0,2,3,5,4,6,7,9,8,10,11,13,12,14,15]
        case 2,6,10,14:
            sortedCells = [2,1,3,0,6,5,7,4,10,9,11,8,14,13,15,12]
        case 3,7,11,15:
            sortedCells = [3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12]
        default:
            fatalError()
        }
        
        return findCharacters(inCells: sortedCells).first!
    }
    
    
    func findCharacter(forRangeAttack position: Int) -> MMUnit {
        let sortedCells: [Int]
        switch position {
        case 0,4,8,12:
            sortedCells = [0,4,8,12,1,5,9,13,2,6,10,14,3,7,11,15]
        case 1,5,9,13:
            sortedCells = [1,5,9,13,0,4,8,12,2,6,10,14,3,7,11,15]
        case 2,6,10,14:
            sortedCells = [2,6,10,14,1,5,9,13,3,7,11,15,0,4,8,12]
        case 3,7,11,15:
            sortedCells = [3,7,11,15,2,6,10,14,1,5,9,13,0,4,8,12]
        default:
            fatalError()
        }
        
        return findCharacters(inCells: sortedCells).first!
        
    }
    
    
    
    func findUnitsInRow(inPosition pos: Int) -> [MMUnit] {
        let sortedCells: [Int]
        switch pos {
        case 0,1,2,3:
            sortedCells = [0,1,2,3]
        case 4,5,6,7:
            sortedCells = [4,5,6,7]
        case 8,9,10,11:
            sortedCells = [8,9,10,11]
        case 12,13,14,15:
            sortedCells = [12,13,14,15]
        default:
            fatalError()
        }
        
        return findCharacters(inCells: sortedCells)
    }
    
    
    
    func findUnitsInColumn(inPosition pos: Int) -> [MMUnit] {
        let sortedCells: [Int]
        switch pos {
        case 0,4,8,12:
            sortedCells = [0,4,8,12]
        case 1,5,9,13:
            sortedCells = [1,5,9,13]
        case 2,6,10,14:
            sortedCells = [2,6,10,14]
        case 3,7,11,15:
            sortedCells = [3,7,11,15]
        default:
            fatalError()
        }
        
        return findCharacters(inCells: sortedCells)
    }
    
    
    
    
    
    func findCharacters(crossInPosition position: Int) -> [MMUnit] {
        let rowNumber = 4
        let columnNumber = 4
        let cell = position

        var ret = [Int]()
        ret.append(cell - 1)
        ret.append(cell + 1)
        ret.append(cell)
        ret.append(cell - rowNumber)
        ret.append(cell + rowNumber)
        ret = ret.filter { $0 >= 0 && $0 < columnNumber * rowNumber}
        
        return findCharacters(inCells: ret)
    }
    
    
    
    func findCharacters(nineCubeInPosition position: Int) -> [MMUnit] {
    
        var sortedCells = [Int]()
        let cell = position
        let rowNumber = 4
        let columnNumber = 4
        switch cell {
        case 0:
            sortedCells = [0,1,4,5]
        case 1:
            sortedCells = [0,1,2,4,5,6]
        case 2:
            sortedCells = [1,2,3,5,6,7]
        case 3:
            sortedCells = [2,3,6,7]
        case 4:
            sortedCells = [0,1,4,5,8,9]
        case 7:
            sortedCells = [2,3,6,7,10,11]
        case 8:
            sortedCells = [4,5,8,9,12,13]
        case 11:
            sortedCells = [6,7,10,11,14,15]
        case 12:
            sortedCells = [8,9,12,13]
        case 15:
            sortedCells = [10,11,14,15]
        default:
            var ret = [Int]()
            ret.append(cell - 1)
            ret.append(cell + 1)
            ret.append(cell)
            ret.append(cell - rowNumber)
            ret.append(cell - rowNumber - 1)
            ret.append(cell - rowNumber + 1)
            ret.append(cell + rowNumber)
            ret.append(cell + rowNumber - 1)
            ret.append(cell + rowNumber + 1)
            sortedCells = ret.filter { $0 >= 0 && $0 < columnNumber * rowNumber}
        }
        
        return findCharacters(inCells: sortedCells)
    }
    
    
    func findAllUnits() -> [MMUnit] {
        return self.aliveCharacters
    }
    
    func findUnitsFrontRow() -> [MMUnit] {
        var ret = [MMUnit]()
        
        if let ret1 = self.findCharacters(inCells: [0,4,8,12]).first {
            ret.append(ret1)
        }
        
        if let ret2 = self.findCharacters(inCells: [1,5,9,13]).first {
            ret.append(ret2)
        }
        
        if let ret3 = self.findCharacters(inCells: [2,6,10,14]).first {
            ret.append(ret3)
        }
        
        if let ret4 = self.findCharacters(inCells: [3,7,11,15]).first {
            ret.append(ret4)
        }
        
        
        return ret
        
        
    }
    
    
    
    
}





extension MMBattlePlayer {
    
    
    ///Func
    
    
    var mostSPCharacters: [MMUnit] {
        var ret = [MMUnit]()
        for i in [5,4,3,2,1,0] {
            for char in self.aliveCharacters {
                if char.sp == i {
                    ret.append(char)
                }
            }
            if ret.count > 0 {
                return ret
            }
        }
        fatalError("no characters")
        return []
    }
    
    
    var fewerSPCharacters: [MMUnit] {
        var ret = [MMUnit]()
        for i in 0...5 {
            for char in self.aliveCharacters {
                if char.sp == i {
                    ret.append(char)
                }
            }
            if ret.count > 0 {
                return ret
            }
        }
        Logger.error("no characters")
        return []
    }
    
    
    var mostHPCharacter: MMUnit {
        var ret = self.aliveCharacters[0]
        for char in self.aliveCharacters {
            if char.hp >= ret.hp {
                ret = char
            }
        }
        return ret
    }
    
    
    var fewerHPCharacter: MMUnit {
        var ret = self.aliveCharacters[0]
        for char in self.aliveCharacters {
            if char.hp <= ret.hp {
                ret = char
            }
        }
        return ret
    }
    
    
    var fewerDefUnit: MMUnit {
        return self.aliveCharacters.sorted { (u1, u2) -> Bool in
            u1.def < u2.def
        }.first!
    }
    
    
    var randomUnit: MMUnit {
        let random = Int.random()
        let count = self.aliveCharacters.count
        return self.aliveCharacters[random % count]
    }
    
    
    func randomUnits(count: Int) -> [MMUnit] {
        if self.aliveCharacters.count <= count {
            return self.aliveCharacters
        }
        
        var ret = [MMUnit]()
        while true {
            let rUnit = randomUnit
            var isFound = false
            
            for u in ret {
                
                if let _ = u.userinfo["added"] as? Bool {
                    break
                }

            }
            
            if !isFound {
                rUnit.userinfo["added"] = true
                ret.append(rUnit)
            }
            
            if ret.count == count {
                return ret
            }
            
        }
        
        
        
    }
    
    
}







//
//
//class MMQiongQi: MMCard {
//    
//    override init() {
//        super.init()
//        
//        self.key = "qiongqi"
//        self.id = 16
//        self.name = "穷奇"
//        
//        self.attackRule = .melee
//        self.attackArea = .wings
//        self.attackType = .physics
//        
//        
//        self.ball = Ball.jin.rawValue
//        self.category = CharacterCategory.melee.rawValue
//        
//        
//        //        skill2Factor = 1.5
//        
//        
//        self.sp = 3
//        self.hp = 100
//        self.atk = 30
//        self.def = 10
//        self.mag = 0
//        self.spd = 70
//        
//    }
//    
//    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
//        super.didHit(character: character, mainTargetDamage: damage, allTargetDamages: allTargetDamages)
//        
//        for tar in allTargetDamages {
//            if tar.destination!.key != damage.destination!.key {
//                tar.destination?.addBuff(MMBuffXuanYun())
//                character.player?.record.putAfterFight(character.createCustomAnimationDictionary(type: .addBuff(key: "xuanyun")))
//            }
//        }
//        
//    }
//    
//    
//}
