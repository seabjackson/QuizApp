//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by Seab Jackson on 4/23/22.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_rendersQuestionHeaderText() {
        let sut = QuestionViewController(question: "Q1", options: [])
        
        _ = sut.view
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withNoOptions_rendersNoOptions() {
        let sut = QuestionViewController(question: "Q1", options: [])

        _ = sut.view
        XCTAssertEqual(sut.listView.numberOfItems(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withOneOption_rendersOneOption() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])

        _ = sut.view
        XCTAssertEqual(sut.listView.numberOfItems(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withOneOption_rendersOneOptionText () {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])

        _ = sut.view
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.listView.dataSource?.collectionView(sut.listView, cellForItemAt: indexPath) as? SimpleCell
        XCTAssertEqual(cell?.textLabel.text, "A1")
    }
    
}
