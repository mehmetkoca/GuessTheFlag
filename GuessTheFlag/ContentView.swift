//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mehmet Koca on 29.04.2020.
//  Copyright © 2020 Mehmet Koca. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "USA"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var shouldShowCorrectAnswer = false
    @State private var selectedCountry: Int?

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .fixedSize()

                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }.fixedSize()

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                
                Text("Score: \(score)")
                    .foregroundColor(.white)

                Spacer()
            }
            .padding(.top, 16.0)
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: shouldShowCorrectAnswer
                    ? Text("Wrong! That’s the flag of \(countries[selectedCountry ?? 0])")
                    : Text("Your score is \(score)"),
                  dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                self.shouldShowCorrectAnswer = false
            })
        }
    }
}

// MARK: - Helper Methods

private extension ContentView {
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 10
        } else {
            scoreTitle = "Wrong"
            score -= 10
            shouldShowCorrectAnswer = true
            selectedCountry = number
        }

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
