//
//  Quiz.swift
//  QuizView
//
//  Created by Taof on 6/24/20.
//  Copyright © 2020 taoquynh. All rights reserved.
//

import Foundation

struct Question: Codable {
    // câu hỏi
    let question: String
    // câu trả lời đúng
    let indexRightAnswer: Int
    // mảng câu trả lời
    var answers: [Answer]
}

struct Answer: Codable {
    var answer: String
    var isSelected: Bool
}


var quizData: [Question] = load("QuizData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    let decoder = JSONDecoder()
    do {
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
