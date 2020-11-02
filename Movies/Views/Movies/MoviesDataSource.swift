//
//  MoviesDataSource.swift
//  Movies
//
//  Created by Dogan Ekici on 2.11.2020.
//

import UIKit

class MoviesDataSource: NSObject, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.ReuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        return cell
    }
}
