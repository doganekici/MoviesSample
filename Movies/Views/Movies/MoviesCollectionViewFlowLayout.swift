//
//  MoviesCollectionViewFlowLayout.swift
//  Movies
//
//  Created by Dogan Ekici on 2.11.2020.
//

import UIKit

enum CollectionViewDisplay {
    case list
    case grid
}

class MoviesCollectionViewFlowLayout: UICollectionViewFlowLayout {
    static let GridCellHeightRatio: CGFloat = 3/2
    static let ListCellHeightRatio: CGFloat = 2/3
    
    convenience init(display: CollectionViewDisplay) {
        self.init()
        
        self.scrollDirection = .vertical
        self.display = display
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 10
        self.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        self.configureLayout()
    }
    
    var display : CollectionViewDisplay = .grid {
        didSet {
            if display != oldValue {
                self.invalidateLayout()
            }
        }
    }
    
    func configureLayout() {
        switch display {
        case .grid:
            if let collectionView = self.collectionView, collectionView.frame.size.width > 0 {
                let collectionViewWidth = (collectionView.frame.width - minimumInteritemSpacing - self.sectionInset.left - self.sectionInset.right) / 2
                let collectionViewHeight = collectionViewWidth * MoviesCollectionViewFlowLayout.GridCellHeightRatio
                self.itemSize = CGSize(width: collectionViewWidth , height: collectionViewHeight)
            }
            
        case .list:
            if let collectionView = self.collectionView, collectionView.frame.size.width > 0 {
                let collectionViewWidth = (collectionView.frame.width - self.sectionInset.left - self.sectionInset.right)
                let collectionViewHeight = collectionViewWidth * MoviesCollectionViewFlowLayout.ListCellHeightRatio
                self.itemSize = CGSize(width: collectionViewWidth, height: collectionViewHeight)
            }
        }
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.configureLayout()
    }
}
