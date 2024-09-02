//
//  ResultView.swift
//  QuizGame2
//
//  Created by Fırat Ören on 1.09.2024.
//

import SwiftUI

struct ResultView: View {
    
    @ObservedObject var quizModel: QuizModel
    @Binding var showingQuiz: Bool
    
    
    var body: some View {
        VStack{
            
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20), style: .continuous)
                .fill(Color.orange.opacity(0.5))
                .frame(maxWidth: .infinity,maxHeight: 60)
                .overlay {
                    Text("Your score is \(quizModel.score)/\(quizModel.questions.count)")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.black)
                }
            
            Button(action: {
              //  quizModel.resetQuiz()
                showingQuiz = false
            }, label: {
                Text("Reset the game")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .bold()
                    .background(Color.green)
                    .foregroundStyle(Color.white)
                    .cornerRadius(12)
            })
            
            
        }.padding()
    }
}

#Preview {
    ResultView(quizModel: QuizModel(), showingQuiz: .constant(false))
}
