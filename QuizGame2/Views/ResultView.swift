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
    
    let columns = [GridItem(.adaptive(minimum: 80, maximum: 80))]

    func questionRecBackground(result: Result) -> Color {
        if result.isTrue {
            return Color.green
        } else {
            return Color.red
        }
    }

    var body: some View {
        VStack(alignment: .leading){

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
            
            Text("Questions")
                .font(.title2)
                .bold()
                .padding()

            LazyVGrid(columns: columns, content: {
                ForEach(0 ..< quizModel.resultKeeper.count) { item in
                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                        .fill(questionRecBackground(result: quizModel.resultKeeper[item]))
                        .frame(width: 50,height: 50)
                        .overlay {
                            Text("\(item + 1)")
                                .foregroundStyle(Color.white)
                                .bold()
                        }
                }
            })



        }.padding()

        







    }
}

#Preview {
    ResultView(quizModel: QuizModel(), showingQuiz: .constant(false))
}
