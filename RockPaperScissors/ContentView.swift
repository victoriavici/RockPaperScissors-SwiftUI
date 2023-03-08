//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sebastian Mraz on 08/03/2023.
//

import SwiftUI

struct ContentView: View {

    @State var myChoice: Choice = .rock
    @State var opponentsChoice: Choice = .paper
    @State var opponentsChoiceIsShown = false
    @State var showingResult = false
    
    var randomChoice: Choice {
        let choices: [Choice] = [.rock, .scissors, .paper]
        let randomIndex = Int.random(in: 0...2)
        return choices[randomIndex]
    }
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(height: geo.size.height  / 2)
                            .foregroundColor(.black)
                        if opponentsChoiceIsShown {
                            Image(systemName: opponentsChoice.rawValue)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(height: geo.size.height / 3)
                                .padding()
                        } else {
                            Button {
                                opponentsChoice = randomChoice
                                opponentsChoiceIsShown = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                        withAnimation(.spring()) {   showingResult = true
                                    }
                                }
                                    
                            } label: {
                                Text("PLAY")
                                    .foregroundColor(.white)
                                    .font(.system(size: 72, weight: .bold))
                                    .padding()
                            }
                        }
                    }
                    ZStack {
                        Rectangle()
                            .frame(height: geo.size.height / 2)
                            .foregroundColor(.white)
                        VStack {
                            Image(systemName: myChoice.rawValue)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(height: geo.size.height / 3)
                                .padding()
                            
                            HStack(spacing: 40) {
                                CustomButton(choice: .rock, myChoice: $myChoice)
                                CustomButton(choice: .paper, myChoice: $myChoice)
                                CustomButton(choice: .scissors, myChoice: $myChoice)
                            }
                        }
                    }
                }
                Text(getResult().rawValue.uppercased())
                            .font(.system(size: 75, weight: .bold))
                            .padding(50)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .border(Color.white, width: 3)
                            .cornerRadius(3)
                            .offset(x: showingResult ? 0 : -400)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    showingResult = false
                                }
                                opponentsChoiceIsShown = false
                            
                        

                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
    func getResult() -> Result {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light)
    }
}

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

struct CustomButton: View {
    let choice: Choice
    @Binding var myChoice: Choice
    var isPicked: Bool {
        return choice == myChoice
    }
    
    var body: some View {
        Button {
            print(choice)
            myChoice = choice
        } label: {
            Image(systemName: choice.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .foregroundColor(isPicked ? .blue : .black)
        }
    }
}
