//
//  Model.swift
//  RockPaperScissors
//
//  Created by Sebastian Mraz on 08/03/2023.
//

import Foundation

enum Choice: String{
    case rock = "octagon.fill"
    case scissors = "scissors"
    case paper = "newspaper.fill"
}

enum Result: String {
    case win
    case loose
    case draw
}
