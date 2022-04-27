//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Seab Jackson on 4/23/22.
//

import UIKit

class QuestionViewController: UIViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    typealias CellRegistration = UICollectionView.CellRegistration<SimpleCell, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>

    private var question = ""
    private var options = [String]()
    private var selection: ((String) -> Void)? = nil
    
    convenience init(question: String, options: [String], selection: @escaping (String) -> Void) {
        self.init()
        self.question = question
        self.options = options
        self.selection = selection
    }
    
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
    
    lazy var dataSource = makeDataSource()
    
 
    
    func configureLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.backgroundColor = .green
        return UICollectionViewCompositionalLayout.list(using: configuration)
        
    }
    
    private func applySnapshot(with options: [String], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(options)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func makeDataSource() -> DataSource {
        let cellRegistration = makeCellRegistration()
        
        let dataSource = DataSource(collectionView: listView) { collectionView, indexPath, option in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: option)
        }
        return dataSource
    }
    
    func makeCellRegistration() -> CellRegistration {
        CellRegistration { cell, indexPath, option in
//            var configuraton = cell.defaultContentConfiguration()
//            configuraton.text = option
//            cell.contentConfiguration = configuraton
            cell.textLabel.text = option
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureViewHierarchy()
        configureConstraints()
        
        listView.delegate = self
        headerLabel.text = question
        applySnapshot(with: options)
        
    }
    
    func configureViewHierarchy() {
        self.view.addSubview(headerLabel)
        self.view.addSubview(listView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            headerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            
            
            listView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            listView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            listView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            listView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - UICollectionViewDelegate
extension QuestionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedAnswer = dataSource.itemIdentifier(for: indexPath) {
            selection?(selectedAnswer)
        }
        
    }
}


class SimpleCell: UICollectionViewListCell {
    lazy var textLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0)
        ])
    }
}
