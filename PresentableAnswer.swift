//
//  PresentableAnswer.swift
//  QuizApp
//
//  Created by Seab Jackson on 5/9/22.
//

import Foundation

struct PresentableAnswer: Hashable {
    let question: String
    let answer: String
    let wrongAnswer: String?
}
