//
//  ResultsViewControllerTest.swift
//  QuizAppTests
//
//  Created by Seab Jackson on 4/27/22.
//

import Foundation
import XCTest
@testable import QuizApp

class ResultsViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_rendersSummary() {
        XCTAssertEqual(makeSUT(summary: "a summary").headerLabel.text, "a summary")
    }
     
    func test_viewDidLoad_rendersAnswers() {
        XCTAssertEqual(makeSUT(answers: []).listView.numberOfItems(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeAnswer()]).listView.numberOfItems(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_rendersCorrectCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1", isCorrect: true)
        let sut = makeSUT(answers: [answer])

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.listView.dataSource?.collectionView(sut.listView, cellForItemAt: indexPath) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_configuresCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "wrong", isCorrect: false)
        let sut = makeSUT(answers: [answer])

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.listView.dataSource?.collectionView(sut.listView, cellForItemAt: indexPath) as? WrongAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
    }
     
    
    // MARK: - Helpers
     
    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    func makeAnswer(question: String = "", answer: String = "", wrongAnswer: String? = nil, isCorrect: Bool = false) -> PresentableAnswer {
        return PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
    }
    
}
 
