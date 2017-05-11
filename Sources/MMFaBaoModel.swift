//
//  MMFaBaoModel.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import OCTJSON
import Kitura


protocol MMFabaoModel {
    
    var key: String { get set }
    var id: Int { get set }
    var name: String { get set }
    
    
    
    var hp: Int { get set }
    var atk: Int { get set }
    var def: Int { get set }
    var mag: Int { get set }
    var spd: Int { get set }
    
    var baoji: Int { get set }
    var shanbi: Int { get set }
    var mingzhong: Int { get set }
    var gedang: Int { get set }
    
    var zaisheng: Int { get set }
    var xixue: Int { get set }
    var fantanwuli: Int { get set }
    var fantanfashu: Int { get set }
        
}


class MMFaBao000: MMFabaoModel {
    var key: String = "000"
    var id: Int = 0
    var name: String = "默认法宝"
    
    
    var hp: Int = 0
    var atk: Int = 0
    var def: Int = 0
    var mag: Int = 0
    var spd: Int = 0
    
    var baoji: Int = 0
    var shanbi: Int = 0
    var mingzhong: Int = 0
    var gedang: Int = 0
    
    
    var zaisheng: Int = 0
    var xixue: Int = 0
    var fantanwuli: Int = 0
    var fantanfashu: Int = 0
}





let kKey = "key"
let kLastLogin = "lastlogin"
let kName = "name"


let kBall = "ball"
let kCategory = "category"

let kSkill0 = "skill0"
let kSkill1 = "skill1"
let kSkill2 = "skill2"


let kUserKey = "userkey"
let kVIPLevel = "viplevel"
let kLevel = "level"
let kPVELevel = "pvelevel"
let kPVPLevel = "pvplevel"
let kYuanBao = "yuanbao"
let kGold = "gold"

let kCardKey = "cardkey"
let kCard = "card"
let kWeapon = "weapon"
let kArmor = "armor"
let kTrinket = "trinket"
let kMisc = "misc"
let kPosition = "position"
let kCharacter = "character"
let kCharacters = "characters"


let kWeapons = "weapons"
let kArmors = "armors"
let kTrinkets = "trinkets"
let kMiscs = "miscs"


let kCharacterKey = "characterkey"
let kType = "type"

let kCards = "cards"
let kArmy = "army"



let kRarity = "rarity"
let kImageName = "imagename"
let kDisplayeName = "displayname"
let kCount = "count"
let kUsage = "usage"


let kStory = "story"
let kSkill1Description = "skill1description"
let kSkill2Description = "skill2description"


let kMaxHP = "maxhp"
let kMaxSP = "maxsp"
let kSP = "sp"
let kHP = "hp"
let kAtk = "atk"
let kMag = "mag"
let kDef = "def"
let kSpd = "spd"
let kBaoJi = "baoji"
let kMingZhong = "mingzhong"
let kShanBi = "shanbi"
let kGeDang = "gedang"

let kATK = "atk"
let kDEF = "def"
let kMAG = "mag"
let kSPD = "spd"


let kZaiSheng = "zaisheng"
let kXiXue = "xixue"
let kFanTanWuLi = "fantanwuli"
let kFanTanFaShu = "fantanfashu"

let kBuff = "buff"
let kSkill = "skill"
let kBuffs = "buffs"
let kSkills = "skills"


let kBattleKey = "battlekey"
let kBattleID = "battleid"
let kPlayerKey = "playerkey"


extension JSON {
    var stringValue: String {
        return self.string!
    }
    
    var intValue: Int {
        return self.int!
    }
}



extension RouterRequest {
    
    var jsonBody: JSON? {
        do {
            
            guard let s = try self.readString() else {
                return nil
            }
            
            return try JSON.deserialize(s)
            
        } catch {
            return nil
        }
    }
    
}






