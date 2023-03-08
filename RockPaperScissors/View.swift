//
//  View.swift
//  RockPaperScissors
//
//  Created by Sebastian Mraz on 08/03/2023.
//

import Foundation
import SwiftUI
import Combine

struct CustomButton: View {
        
    let choice: Choice
    @Binding var myChoice: Choice
    @Binding var canClick: Bool
    @Binding var isPicked: Bool
    
    var onAction: () -> Void
    
    var body: some View {
        Button {
            if !canClick {
                onAction()
            }
        } label: {
            Image(systemName: choice.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .foregroundColor(isPicked ? .blue : .black)
        }
    }
}
