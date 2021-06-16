//
//  CIFilterController.swift
//  刻画
//
//  Created by 王小林 on 2021/6/16.
//  Copyright © 2021 suin. All rights reserved.
//

import Foundation
import UIKit
class CIFilterController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let filterAr = Array<CIFilter>.init()//存储滤镜
    var filter = CIFilter.init()//当前滤镜
    var startPoint = CGPoint.init();//开始点
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - 事件
    
    @IBAction func toExitAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func okAction(_ sender: Any) {
    }
    @IBAction func pinchAction(_ sender: UIPinchGestureRecognizer) {
    }
    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
    }
    
    // MARK: - dataSource/delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterAr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CammraCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cammraCell", for: indexPath)
        
        cell.imageView.backgroundColor = UIColor.white
        cell.imageView.layer.masksToBounds = true
        cell.imageView.layer.cornerRadius = 8
        
        let filter = CIFilter.init(name: <#T##String#>)
        
        return cell
        
    }
    
    func initFilter(_ name:String) -> CIFilter {
        let filter = CIFilter.init(name: name)
        
        switch name {
        case <#pattern#>:
            <#code#>
        default:
            <#code#>
        }
        
        return filter
    }
}
