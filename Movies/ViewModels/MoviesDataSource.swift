//
//  MoviesDataSource.swift
//  Movies
//
//  Created by Dogan Ekici on 2.11.2020.
//

import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class MoviesDataSource: GenericDataSource<Movie>, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.ReuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        cell.lblTitle.text = data.value[indexPath.row].title
        cell.imgMovie.loadImage(witUrlString: data.value[indexPath.row].posterPath)
        let collectionViewLayout = collectionView.collectionViewLayout as! MoviesCollectionViewFlowLayout
        
        if collectionViewLayout.display == CollectionViewDisplay.grid{
            cell.lblTitle.textAlignment = .center
        }else{
            cell.lblTitle.textAlignment = .left
        }
        
        return cell
    }
}
