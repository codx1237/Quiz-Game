//
//  ContentView.swift
//  QuizGame2
//
//  Created by Fırat Ören on 1.09.2024.
//

import SwiftUI

struct QuestionView: View {
    
    @ObservedObject var quizModel: QuizModel
    
    @State private var selectedAnswer = ""
    @State private var isAnswerTapped = false
    @State private var timeRemaining = 20
    @State private var timer: Timer?
    @Binding var showingQuiz: Bool
    
    @State var shuffledAnswers: [String] = []
    

    func buttonBackgroundColor(for answer: String) -> Color {
        if !isAnswerTapped && timeRemaining > 0 {
            return Color.orange
        } else {
            if quizModel.questions[quizModel.currentQuestionIndex].correct_answer == answer {
                return Color.green
            } else if answer == selectedAnswer {
                return Color.red
            } else {
                return Color.orange
            }
        }
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.isAnswerTapped = true
                self.resetTimer()
            }
        })
    }
    
    func resetTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    var body: some View {
        VStack {
            if !quizModel.quizCompleted && quizModel.errorMessage == nil {
                HStack{
                    Spacer()
                    Text("Quiz")
                        .font(.title)
                        .foregroundStyle(Color.brown)
                        .bold()
                    Spacer()
                    Circle()
                        .fill(Color.brown)
                        .frame(width: 50)
                        .overlay {
                            Text("\(timeRemaining)")
                                .font(.title2)
                                .foregroundStyle(Color.white)
                                .bold()
                        }
                }
                
                ProgressView(value: Double(quizModel.currentQuestionIndex + 1), total: Double(quizModel.questions.count))
                    .tint(Color.green)
                
                HStack(spacing: 0){
                    Text("\(quizModel.currentQuestionIndex + 1)/")
                        .font(.system(size: 24))
                        .padding(.top)
                        .foregroundStyle(Color.green)
                        .bold()
                    Text("\(quizModel.questions.count)")
                        .font(.system(size: 22))
                        .padding(.top)
                        .foregroundStyle(Color.brown)
                        .bold()
                    Spacer()
                }
                
                VStack(alignment: .center){
                    Text("\(quizModel.questions[quizModel.currentQuestionIndex].question)")
                        .font(.title)
                        .foregroundStyle(Color.brown)
                        .bold()
                        .padding(.top)
                        
                    ForEach(shuffledAnswers,id: \.self) { answer in
                        
                        Button(action: {
                            selectedAnswer = answer
                            isAnswerTapped = true
                            resetTimer()
                            if selectedAnswer == quizModel.questions[quizModel.currentQuestionIndex].correct_answer {
                                quizModel.resultKeeper.append(Result(question: quizModel.questions[quizModel.currentQuestionIndex], isTrue: true))
                            } else {
                                quizModel.resultKeeper.append(Result(question: quizModel.questions[quizModel.currentQuestionIndex], isTrue: false))
                            }
                        }, label: {
                            Text(answer)
                                .padding()
                                .frame(width: 300)
                                .background(buttonBackgroundColor(for: answer))
                                .cornerRadius(12)
                                .foregroundStyle(Color.white)
                                .font(.system(size: 30))
                                .bold()
                                .minimumScaleFactor(0.5)
                                
                        }).disabled(isAnswerTapped ? true : false)
                        
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if isAnswerTapped {
                            if quizModel.currentQuestionIndex < (quizModel.questions.count - 1) {
                                print("\(quizModel.currentQuestionIndex)")
                                quizModel.checkAnswer(selectedAnswer)
                                resetTimer()
                                timeRemaining = 20
                                startTimer()
                                isAnswerTapped = false
                                shuffledAnswers = (quizModel.questions[quizModel.currentQuestionIndex].incorrect_answers + [quizModel.questions[quizModel.currentQuestionIndex].correct_answer]).shuffled()
                            } else {
                                quizModel.quizCompleted = true
                            }
                        }
                    }, label: {
                        Text("Next Question")
                            .padding()
                            .frame(width: 200)
                            .font(.title2)
                            .bold()
                            .background(Color.green)
                            .foregroundStyle(Color.white)
                            .cornerRadius(12)
                        
                    })
                    
                }
                
                Spacer()
            } // if block
            else if quizModel.isLoading {
                ProgressView("Loading...")
            } else if quizModel.errorMessage != nil {
                Text("There was an error! \(quizModel.errorMessage ?? "")")
                Button(action: {
                   // quizModel.resetQuiz()
                    showingQuiz = false
                }, label: {
                    Text("Try again")
                        .padding()
                        .frame(width: 200)
                        .font(.title2)
                        .bold()
                        .background(Color.green)
                        .foregroundStyle(Color.white)
                        .cornerRadius(12)
                })
                
            } else {
                ResultView(quizModel: quizModel, showingQuiz: $showingQuiz)
            }
        }
        .onAppear{
            if quizModel.errorMessage == nil {
                shuffledAnswers = (quizModel.questions[quizModel.currentQuestionIndex].incorrect_answers + [quizModel.questions[quizModel.currentQuestionIndex].correct_answer]).shuffled()
                startTimer()
            }

        }
        .padding()
        //.background(Color(uiColor: UIColor.secondarySystemBackground))
    }
}

//#Preview {
//    QuestionView(quizModel: QuizModel())
//}
