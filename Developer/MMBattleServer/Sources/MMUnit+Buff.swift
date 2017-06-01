//
//  MMCharacter+Buff.swift
//  AAA
//
//  Created by yuhan zhang on 10/29/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


extension MMUnit {
    
    
    func addBuff(_ buff: MMBuff) {
        if let selfbuff = self.findBuff(buff.key) {
            selfbuff.reset()
            return
        }
        
        buff.character = self
        buff.willAddToCharacter()
        self.buffs.append(buff)
        buff.didAddToCharacter()
    }
    
    
    
    func hasBuff(_ s: String) -> Bool {
        return self.buffs.map { $0.key }.contains(s)
    }
    
    func findBuff(_ s: String) -> MMBuff? {
        for buff in self.buffs {
            if buff.key == s {
                return buff
            }
        }
        
        return nil
    }
    
    
    func removeBuff(_ buff: MMBuff) {
        buff.willRemoveFromCharacter()
        self.buffs = self.buffs.filter { $0.key != buff.key }
        buff.didRemoveFromCharacter()
    }
    
}













