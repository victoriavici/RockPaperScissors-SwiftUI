//
//  RockPaperScissorsApp.swift
//  RockPaperScissors
//
//  Created by Sebastian Mraz on 08/03/2023.
//

import SwiftUI

@main
struct RockPaperScissorsApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: RockPaperScissorsDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
