//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sebastian Mraz on 08/03/2023.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        
        GeometryReader { proxy in
            ZStack {
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(height: proxy.size.height  / 2)
                            .foregroundColor(.black)
                        if viewModel.opponentsChoiceIsShown {
                            Image(systemName: viewModel.opponentsChoice.rawValue)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(height: proxy.size.height / 3)
                                .padding()
                        } else {
                            Button {
                                viewModel.setOpponentChoice()
                                viewModel.setOpponentShown()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    withAnimation(.spring()) {
                                        viewModel.setShowingResult()
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
                        
                        VStack {
                            Image(systemName: viewModel.myChoice.rawValue)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(height: proxy.size.height / 3)
                                .padding()
                            
                            HStack(spacing: 40) {
                                CustomButton(choice: .rock, myChoice: $viewModel.myChoice, canClick: $viewModel.opponentsChoiceIsShown,
                                             isPicked: .init(get: {
                                    viewModel.myChoice == .rock
                                }, set: { _ in
                                })) {
                                    viewModel.myChoice = .rock
                                }
                                CustomButton(choice: .paper, myChoice: $viewModel.myChoice, canClick: $viewModel.opponentsChoiceIsShown,
                                             isPicked: .init(get: {
                                    viewModel.myChoice == .paper
                                }, set: { _ in
                                })) {
                                    viewModel.myChoice = .paper
                                }
                                CustomButton(choice: .scissors, myChoice: $viewModel.myChoice, canClick: $viewModel.opponentsChoiceIsShown,
                                             isPicked: .init(get: {
                                    viewModel.myChoice == .scissors
                                }, set: { _ in
                                })) {
                                    viewModel.myChoice = .scissors
                                }
                            }
                        }
                        .background(
                            Rectangle()
                                .frame(height: proxy.size.height / 2)
                                .foregroundColor(.white),
                            alignment: .top
                        )
                }
                Text(viewModel.getResult(opponentsChoice: viewModel.opponentsChoice, myChoice: viewModel.myChoice).rawValue.uppercased())
                            .font(.system(size: 75, weight: .bold))
                            .padding(50)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .border(Color.white, width: 3)
                            .cornerRadius(3)
                            .offset(x: viewModel.showingResult ? 0 : -400)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    viewModel.setShowingResult()
                                }
                                viewModel.setOpponentShown()
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light)
    }
}


