//
//  Result.swift
//  QuizGame2
//
//  Created by Fırat Ören on 4.09.2024.
//

import Foundation

struct Result:Identifiable {
    let id = UUID()
    let question: Question
    let isTrue: Bool
}
