//
//  TableViewHelpers.swift
//  QuizAppTests
//
//  Created by Seab Jackson on 4/27/22.
//

import Foundation
import UIKit
 
extension UICollectionView {
    func cell(at row: Int) -> UICollectionViewCell? {
        return dataSource?.collectionView(self, cellForItemAt: IndexPath(row: row, section: 0))
    }

}
