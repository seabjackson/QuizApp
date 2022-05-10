//
//  CorrectAnswerCell.swift
//  QuizApp
//
//  Created by Seab Jackson on 5/9/22.
//

import UIKit

class CorrectAnswerCell: UICollectionViewCell {
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

