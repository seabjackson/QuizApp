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
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
        
    func test_viewDidLoad_rendersOptions() {
        XCTAssertEqual(makeSUT(options: []).listView.numberOfItems(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).listView.numberOfItems(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).listView.numberOfItems(inSection: 0), 2)
    }
    
    func test_viewDidLoad_rendersOneOptionsText () {
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).listView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).listView.title(at: 1), "A2")
    }
    
    func test_optionsSelected_notifiedDelegate() {
        var receivedAnswer = ""
        let sut = makeSUT(options: ["A1"]) {
            receivedAnswer = $0
        }
        let indexPath = IndexPath(row: 0, section: 0)
        sut.listView.delegate?.collectionView?(sut.listView, didSelectItemAt: indexPath)
        XCTAssertEqual(receivedAnswer, "A1")
    }
    
    // MARK: - Helpers
    
    func makeSUT(question: String = "", options: [String] = [], selection: @escaping (String) -> Void = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view
        return sut
    }
    
}

private extension UICollectionView {
    func cell(at row: Int) -> SimpleCell? {
        let indexPath = IndexPath(row: row, section: 0)
        return dataSource?.collectionView(self, cellForItemAt: indexPath) as? SimpleCell
    }
    
    func title(at row: Int) -> String? {
        cell(at: row)?.textLabel.text
    }
}
