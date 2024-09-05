//
//  QuizModel.swift
//  QuizGame2
//
//  Created by Fırat Ören on 1.09.2024.
//

import Foundation

@MainActor
class QuizModel: ObservableObject {
    
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var score = 0
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var quizCompleted = false
    @Published var resultKeeper: [Result] = []

    let categories: [Category] = [
        Category(id: 9, name: "General Knowledge"),
        Category(id: 10, name: "Entertainment: Books"),
        Category(id: 11, name: "Entertainment: Film"),
        Category(id: 12, name: "Entertainment: Music"),
        Category(id: 14, name: "Entertainment: Television"),
        Category(id: 15, name: "Entertainment: Video Games"),
        Category(id: 17, name: "Science & Nature"),
        Category(id: 18, name: "Science: Computers"),
        Category(id: 19, name: "Science: Mathematics"),
        Category(id: 22, name: "Geography"),
        Category(id: 23, name: "History"),
        Category(id: 24, name: "Politics"),
        Category(id: 27, name: "Animals")
    ]
    
    func fetchQuestions(for category: Category?, difficulty: Difficulty) async {
        isLoading = true
        errorMessage = nil
        resetQuiz()
        do {
            let questions = try await fetchQuestionsFromAPI(category: category, difficulty: difficulty)
            self.questions = questions
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
        }
    }
    
    
    private func fetchQuestionsFromAPI(category: Category?, difficulty: Difficulty) async throws -> [Question] {
        var urlComponents = URLComponents(string: "https://opentdb.com/api.php")
        urlComponents?.queryItems = [
            URLQueryItem(name: "amount", value: "10"),
            URLQueryItem(name: "type", value: "multiple")
        ]
        
        if let category = category {
            urlComponents?.queryItems?.append(URLQueryItem(name: "category", value: String(category.id)))
        }
        
        
        urlComponents?.queryItems?.append(URLQueryItem(name: "difficulty", value: difficulty.apiValue))
        
        
        guard let url = urlComponents?.url else {
            throw QuizError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw QuizError.invalidResponse
        }
        
        let quizResponse = try JSONDecoder().decode(Quiz.self, from: data)
        return quizResponse.results
    }
    
    func checkAnswer(_ answer: String) {
        if answer == questions[currentQuestionIndex].correct_answer {
            score += 1
        }
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            quizCompleted = true
        }
    }
    
    func resetQuiz() {
        questions = []
        currentQuestionIndex = 0
        score = 0
        errorMessage = nil
        quizCompleted = false
    }
    
    
    
    
    
    
}

