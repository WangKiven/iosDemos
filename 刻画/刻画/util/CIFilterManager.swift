//
//  CIFilterManager.swift
//  刻画
//
//  Created by 王小林 on 2021/6/23.
//  Copyright © 2021 suin. All rights reserved.
//

import Foundation

// 图片源头
enum OutImageOrigin {
    // selectedOrigin 用户选择的图片, thumbOrigin 缩略图
    case selectedOrigin, thumbOrigin
}

class CIFilterManager {
    let filterNames:Array<String>// 所有filter的名称
    var filters = [String: CIFilter]()// 存储用户选择图片用的filter
    var filtersForThumb = [String: CIFilter]()// 存储缩略图用的filter
    
    var selectedFilterName:String? // 用户选择的filter
    
    
    let image:UIImage // 用户选择的图片
    let imageExtent:CGRect // 用户选择的图片的大小
    
    let thumb:UIImage // 缩略图
    let thumbExtent:CGRect // 缩略图的大小
    
    init(image:UIImage, thumb:UIImage) {
        self.image = image
        imageExtent = CIImage.init(cgImage: image.cgImage!).extent
        
        self.thumb = thumb
        thumbExtent = CIImage.init(cgImage: thumb.cgImage!).extent
        
        filterNames = CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
    }
    
    func getOutImage(filterName:String, origin:OutImageOrigin) -> UIImage {
        let filter = getFilter(filterName: filterName, origin: origin)
        
        if let oi = filter.outputImage {
            var ff = oi.extent
            if ff.origin.x <= 0 {
                if origin == .selectedOrigin {
                    ff = imageExtent
                } else {
                    ff = thumbExtent
                }
                
                let cgimg = CIContext.init().createCGImage(oi, from: ff)
                if cgimg != nil {
                    return UIImage.init(cgImage: cgimg!)
                }
            } else {
                return UIImage.init(ciImage: oi)
            }
        }
        return UIImage.init()
    }
    
    func getFilter(filterName:String, origin:OutImageOrigin) -> CIFilter {
        var filter:CIFilter?
        
        if origin == .selectedOrigin {
            filter = filters[filterName]
        } else {
            filter = filtersForThumb[filterName]
        }
        
        if filter == nil {
            let filter1 = createFilter(filterName: filterName, origin: .selectedOrigin)
            filters[filterName] = filter1
            
            let filter2 = createFilter(filterName: filterName, origin: .thumbOrigin)
            filtersForThumb[filterName] = filter2
            
            if origin == .selectedOrigin {
                filter = filter1
            } else {
                filter = filter2
            }
        }
        
        return filter!
    }
    
    func createFilter(filterName:String, origin:OutImageOrigin) -> CIFilter {
        let filter = CIFilter.init(name: filterName)!
        
        return filter
    }
}
