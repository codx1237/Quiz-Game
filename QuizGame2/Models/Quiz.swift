//
//  Quiz.swift
//  QuizGame2
//
//  Created by Fırat Ören on 1.09.2024.
//

import Foundation


struct Question: Decodable, Identifiable {
    let id = UUID()
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
     
}

struct Quiz: Decodable {
    let results: [Question]
}


struct Category: Identifiable, Hashable {
    let id: Int
    let name: String
}

enum Difficulty: String, CaseIterable, Identifiable, Hashable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var id: String {
        self.rawValue
    }
    
    var apiValue: String {
        switch self {
        case .easy:
            return "easy"
        case .medium:
            return "medium"
        case .hard:
            return "hard"
        }
    }
}

enum QuizError: Error {
    case invalidUrl
    case invalidResponse
    case decodingError
}
