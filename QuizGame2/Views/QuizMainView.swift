//
//  QuizMainView.swift
//  QuizGame2
//
//  Created by Fırat Ören on 1.09.2024.
//

import SwiftUI

struct QuizMainView: View {
    
    @StateObject private var quizModel = QuizModel()
    
    @State private var selectedCategory: Category = Category(id: 9, name: "General Knowledge")
    @State private var selectedDiff: Difficulty = .easy
    @State private var showingQuiz: Bool = false
 
     
     
    var body: some View {
        NavigationStack {
            VStack {
                
                HStack{
                    Spacer()
                    Text("Select difficulty")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                 
                customSegmentedController(selectedDiff: $selectedDiff)
                    .frame(maxWidth: .infinity,maxHeight: 50)
                
                
                HStack{
                    Spacer()
                    Text("Select a category")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                
                CategoryView(categories: quizModel.categories, selectedCategory: $selectedCategory)
              
                 
                Button(action: {
                    Task{
                        await quizModel.fetchQuestions(for: selectedCategory, difficulty: selectedDiff)
                        showingQuiz = true
                    }
                    
                }, label: {
                    Text("Start Quiz →")
                        .padding()
                        .frame(width: 200,height: 50)
                        .background(Color.green)
                        .cornerRadius(12)
                        .foregroundStyle(Color.white)
                        .font(.title2)
                        .bold()
                })
 
                
                Spacer()
                
            }
            .background(Color(uiColor: UIColor.secondarySystemBackground))
            .onAppear {
                
            }
            .fullScreenCover(isPresented: $showingQuiz) {
                QuestionView(quizModel: quizModel, showingQuiz: $showingQuiz)
            }
            
        }
            
        
        
        
    }
}

#Preview {
    QuizMainView()
}
