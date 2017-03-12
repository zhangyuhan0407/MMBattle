//
//  MMBattlePlayerRepo.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/3/16.
//
//

import Foundation


class MMBattlePlayerRepo {
    static func createBattlePlayer(player: MMPlayer, characters: [MMCharacter], guardians: [MMGuardian]) -> MMBattlePlayer {
        let battlePlayer = MMBattlePlayer(player: player, characters: characters, guardian: guardians)
        
        for char in battlePlayer.characters {
            char.player = battlePlayer
        }
        
        return battlePlayer
    }
}
