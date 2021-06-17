//
//  CIFilterController.swift
//  刻画
//
//  Created by 王小林 on 2021/6/16.
//  Copyright © 2021 suin. All rights reserved.
//

import Foundation
import UIKit

protocol CIFilterDelegate {
    func finshWith(image:UIImage);
}

class CIFilterController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var delegate:CIFilterDelegate?
    @objc var isStandard:Bool = false
    @objc var image:UIImage = UIImage.init()
    var thumbImage = UIImage.init(named: "thumb")!
    
    var filterAr = Array<CIFilter>.init()//存储滤镜
    var filter = CIFilter.init()//当前滤镜
    var startPoint = CGPoint.init();//开始点
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filterNames = CIFilter.filterNames(inCategory: nil)
        filterAr = filterNames.map { (name) -> CIFilter in
            CIFilter.init(name: name)!
        }
        
        collectionView.register(UINib.init(nibName: "CammraCell", bundle: nil), forCellWithReuseIdentifier: "cammraCell")
        collectionView.allowsSelection = true
        collectionView.selectItem(at: NSIndexPath.init(row: 0, section: 0) as IndexPath, animated: false, scrollPosition: .top)
    }
    
    // MARK: - 事件
    
    @IBAction func toExitAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func okAction(_ sender: Any) {
        let image = imageView.image
        
        if image == nil {
            return
        }
        
        if let d = delegate {
            d.finshWith(image: image!)
        }
        
        if !isStandard {
            ToShareOrSaveImage(image, self.view)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startPoint = (touches.first?.location(in: view))!
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let lastPoint = (touches.first?.previousLocation(in: view))!
        if __CGPointEqualToPoint(startPoint, lastPoint) {
            collectionView.isHidden = !collectionView.isHidden
        }
        
        startPoint = CGPoint.init()
    }
    
    @IBAction func pinchAction(_ sender: UIPinchGestureRecognizer) {
        
        let paths = collectionView.indexPathsForSelectedItems
        if paths!.count < 1 {
            return
        }
        let path = paths?.first
        
        let scale = sender.scale
        sender.scale = 1
        
        
    }
    
    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
        
        let paths = collectionView.indexPathsForSelectedItems
        if paths!.count < 1 {
            return
        }
        let path = paths?.first
        
        let tPoint = sender.translation(in: imageView)
        sender.setTranslation(CGPoint.init(), in: imageView)
        
        
    }
    
    // MARK: - dataSource/delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterAr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CammraCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cammraCell", for: indexPath) as! CammraCell
        
        cell.imageView.backgroundColor = UIColor.white
        cell.imageView.layer.masksToBounds = true
        cell.imageView.layer.cornerRadius = 8
        
        let filter = filterAr[indexPath.row]
        
        print("构造行：\(indexPath.row)-\(filter.name)")
        
        let dic = filter.attributes
        var hasInputImageKey = false
        var hasOther = false
        dic.forEach { (key, value) in
            switch (key) {
            case kCIInputImageKey:
                hasInputImageKey = true
                filter.setValue(thumbImage.ciImage, forKey: kCIInputImageKey)
                break
            case kCIInputCenterKey:
                filter.setValue(CIVector.init(x: 10, y: 10), forKey: kCIInputCenterKey)
                break
            case kCIInputTargetImageKey:
                hasOther = true
                break
            case kCIInputTransformKey:
                let vv = NSValue.init(cgAffineTransform: CGAffineTransform.init(scaleX: 0.5, y: 0.33))
                filter.setValue(vv, forKey: kCIInputTransformKey)
                break
            default:
                break
            }
        }
        
        if hasInputImageKey && !hasOther {
            cell.imageView.image = getFilterImage(filter)
        } else {
            cell.imageView.image = nil
        }
        
//        cell.imageView.image = UIImage.init(named: "thumb")
        
        return cell
        
    }
    
    // MARK: -
    
    func initFilter(_ name:String) -> CIFilter {
        let filter = CIFilter.init(name: name)!
        return filter
    }
    
    func getFilterImage(_ filter:CIFilter) -> UIImage? {
        if let oi = filter.outputImage {
            var ff = oi.extent
            if ff.origin.x <= 0 {
                ff = CIImage.init(cgImage: thumbImage.cgImage!).extent
            } else {
                return UIImage.init(ciImage: oi)
            }
            
            let cgimg = CIContext.init().createCGImage(oi, from: ff)
            if cgimg != nil {
                return UIImage.init(cgImage: cgimg!)
            }
        }
        return nil
    }
    
    
    /*
    // 得到过滤后的图片
    CIImage *outputImage = [filter outputImage];
    // 转换图片, 创建基于GPU的CIContext对象
    CGImageRef cgimg;
    
    CGRect ff = [outputImage extent];
    
    if (ff.origin.x <= 0) {
        ff = [[CIImage imageWithCGImage:self.image.CGImage] extent];
    }
    
    cgimg = [self.context createCGImage:outputImage fromRect:ff];
    
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];*/
}
