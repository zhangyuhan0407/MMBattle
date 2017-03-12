//
//  MMBuff.swift
//  MechanMon
//
//  Created by yuhan zhang on 9/21/16.
//
//

import Foundation


class MMBuff: MMCharacterFlow {
    
    var key: String = "DEFAULT"
    var id: Int = 0
    var name: String = "默认BUFF"
    
    var userinfo: [String: Any]?
    
    weak var character: MMCharacter?
    
    var defaultRound = 1 {
        didSet {
            if self.remainRound > defaultRound {
                remainRound = defaultRound
            }
        }
    }
    var remainRound: Int = 1 {
        didSet {
            if remainRound <= 0 {
                self.removeFromCharacter()
            }
        }
    }

    
    func reset() {
        self.remainRound = defaultRound
    }
    
    
    func removeFromCharacter() {
        self.character?.removeBuff(self)
    }
    
    
    
    //Templates
    
    
    func willAddToCharacter() {
        
    }
    
    func didAddToCharacter() {
        
    }
    
    func willRemoveFromCharacter() {
        
    }
    
    func didRemoveFromCharacter() {
        
    }
    
    
}

