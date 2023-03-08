//
//  ViewModel.swift
//  RockPaperScissors
//
//  Created by Sebastian Mraz on 08/03/2023.
//

import Foundation

@MainActor public class ViewModel: ObservableObject {
    
    @Published var myChoice: Choice = .rock
    @Published var opponentsChoice: Choice = .paper
    @Published var opponentsChoiceIsShown = false
    @Published var showingResult = false
    
    func getResult(opponentsChoice: Choice, myChoice: Choice) -> Result {
        
        switch opponentsChoice {
            
        case .rock:
            switch myChoice {
                
            case .rock:
                return .draw
            case .scissors:
                return .loose
            case .paper:
                return .win
            }
        case .scissors:
            switch myChoice {
                
            case .rock:
                return .win
            case .scissors:
                return .draw
            case .paper:
                return .loose
            }
        case .paper:
            switch myChoice {
                
            case .rock:
                return .loose
            case .scissors:
                return .win
            case .paper:
                return .draw
            }
        }
    }
    
    func setShowingResult() {
        objectWillChange.send()
        showingResult = !showingResult
    }
    
    var randomChoice: Choice {
        objectWillChange.send()
        let choices: [Choice] = [.rock, .scissors, .paper]
        return choices.randomElement()!
    }
    
    func setOpponentChoice() {
        objectWillChange.send()
        opponentsChoice = randomChoice
    }
    
    func setOpponentShown() {
        objectWillChange.send()
        opponentsChoiceIsShown = !opponentsChoiceIsShown
    }
}

