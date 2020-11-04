//
//  MoviesDataSource.swift
//  Movies
//
//  Created by Dogan Ekici on 2.11.2020.
//

import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
    var filteredData: DynamicValue<[T]> = DynamicValue([])
}

class MoviesDataSource: GenericDataSource<Movie>, UICollectionViewDataSource {
    var isFiltering = false
    
    func value(atIndex index:Int) -> Movie{
        if isFiltering{
            return self.filteredData.value[index]
        }
        return self.data.value[index]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering{
            return filteredData.value.count
        }
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.ReuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        var data = self.data
        if isFiltering{
            data = filteredData
        }
        
        if FavoriteManager.shared.isFavorite(movie: data.value[indexPath.row]){
            cell.imgFavorite.isHidden = false
        }else{
            cell.imgFavorite.isHidden = true
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionFooter:
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterUCollectionReusableView.ReuseIdentifier, for: indexPath) as! FooterUCollectionReusableView
                
                self.data.addObserver(footerView) { [weak footerView] _ in
                    footerView?.finishLoading()
                }
                
                if isFiltering || data.value.count == 0{
                    footerView.frame.size.height = 0.0
                    footerView.frame.size.width = 0.0
                }
                return footerView

            default:
                assert(false, "Unexpected element kind")
            }
    }
}
