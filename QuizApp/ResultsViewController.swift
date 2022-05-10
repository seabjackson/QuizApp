//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Seab Jackson on 4/27/22.
//

import UIKit


class ResultsViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, PresentableAnswer>
    typealias CorrectAnswerCellRegistration = UICollectionView.CellRegistration<CorrectAnswerCell, PresentableAnswer>
    typealias WrongAnswerCellRegistration = UICollectionView.CellRegistration<WrongAnswerCell, PresentableAnswer>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, PresentableAnswer>
    
    
    private var summary = ""
    private var answers = [PresentableAnswer]()
    
    lazy var dataSource = makeDataSource()
    
    enum Section: Hashable {
        case main
    }
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    lazy var listView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        collectionView.backgroundColor = .green
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewHierarchy()
        configureConstraints()
        
        headerLabel.text = summary
        applySnapshot(with: answers)
    }
    
    private func configureViewHierarchy() {
        self.view.addSubview(headerLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            headerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
        ])
    }
    
    private func configureLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.backgroundColor = .green
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    func makeDataSource() -> DataSource {
        let correctCellRegistration = makeCorrectCellRegistration()
        let wrongCellRegistration = makeWrongCellRegistration()
        
        let dataSource = DataSource(collectionView: listView) { collectionView, indexPath, answer in
            if answer.wrongAnswer == nil {
                return collectionView.dequeueConfiguredReusableCell(using: correctCellRegistration, for: indexPath, item: answer)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: wrongCellRegistration, for: indexPath, item: answer)
            }
        }
        return dataSource
    }
    
    
    func makeCorrectCellRegistration() -> CorrectAnswerCellRegistration {
        CorrectAnswerCellRegistration { cell, indexPath, presentableAnswer in
            cell.questionLabel.text = presentableAnswer.question
            cell.answerLabel.text = presentableAnswer.answer
        }
    }
    
    func makeWrongCellRegistration() -> WrongAnswerCellRegistration {
        WrongAnswerCellRegistration { cell, indexPath, answer in
            cell.questionLabel.text = answer.question
            cell.correctAnswerLabel.text = answer.answer
            cell.wrongAnswerLabel.text = answer.wrongAnswer
        }
    }
    
    
    private func applySnapshot(with answers: [PresentableAnswer], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(answers)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    
}
