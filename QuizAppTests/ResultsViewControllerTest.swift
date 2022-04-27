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
        XCTAssertEqual(makeSUT(answers: [makeDummyAnswer()]).listView.numberOfItems(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_rendersCorrectAnswerCell() {
        let sut = makeSUT(answers: [PresentableAnswer(isCorrect: true)])

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.listView.dataSource?.collectionView(sut.listView, cellForItemAt: indexPath) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
    }
    
    
    func test_viewDidLoad_withWrongAnswer_rendersWrongAnswerCell() {
        let sut = makeSUT(answers: [PresentableAnswer(isCorrect: false)])

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.listView.dataSource?.collectionView(sut.listView, cellForItemAt: indexPath) as? WrongAnswerCell
        XCTAssertNotNil(cell)
    }
    
    // MARK: - Helpers
     
    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    func makeDummyAnswer() -> PresentableAnswer {
        return PresentableAnswer(isCorrect: false)
    }
    
    
}
 
