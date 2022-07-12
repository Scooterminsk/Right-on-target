//
//  Game.swift
//  Right on target
//
//  Created by Zenya Kirilov on 11.05.22.
//

import Foundation

protocol GameProtocol {
    associatedtype SecretType
    // earned points per round count
    var score: Int { get set }
    // secret random value
    var secretValue: SecretType { get set }
    // check, if the game was ended
    var isGameEnded: Bool { get }
    // start new game and start new round
    func restartGame() -> Void
    // start new round and update secret random number
    func startNewRound() -> Void
    // comparison of user's value and secret value, and score count
    func calculateScore(secretValue: SecretType, userValue: SecretType)
}

class Game<T: SecretValueProtocol>: GameProtocol {
    
    typealias SecretType = T
    var score: Int = 0
    // secret value
    var secretValue: T
    // closure that will compare values and return earned score
    private var compareClosure: (T, T) -> Int
    private var roundsCount: Int!
    private var currentRoundNumber: Int = 0
    var isGameEnded: Bool {
        if currentRoundNumber >= roundsCount {
            return true
        } else {
            return false
        }
    }
    
    init(secretValue: T, rounds: Int, compareClosure: @escaping (T, T) -> Int) {
        self.secretValue = secretValue
        roundsCount = rounds
        self.compareClosure = compareClosure
        startNewRound()
    }
    
    func restartGame() {
        score = 0
        currentRoundNumber = 0
        self.secretValue.setRandomValue()
    }
    
    func startNewRound() {
        currentRoundNumber += 1
        self.secretValue.setRandomValue()
    }
    
    func calculateScore(secretValue: T, userValue: T) {
        score = score + compareClosure(secretValue, userValue)
    }
    
}
