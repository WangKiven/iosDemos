//
//  FilterCollectionSelector.swift
//  刻画
//
//  Created by 王小林 on 2021/6/24.
//  Copyright © 2021 suin. All rights reserved.
//

import Foundation
class FilterCollectionSelector: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let filterManager:CIFilterManager
    
    init(filterManager:CIFilterManager) {
        self.filterManager = filterManager
    }
    
    // MARK: - dataSource/delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterManager.filterNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CammraCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cammraCell", for: indexPath) as! CammraCell
        
        cell.imageView.backgroundColor = UIColor.white
        cell.imageView.layer.masksToBounds = true
        cell.imageView.layer.cornerRadius = 8
        
        cell.imageView.image = filterManager.getOutImage(index: indexPath.row, origin: .thumbOrigin)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
