//
//  ViewCtrFooter.h
//  刻画
//
//  Created by Kiven Wang on 14-3-26.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FooterBlock)();

@interface ViewCtrFooter : UICollectionReusableView

@property (nonatomic, strong) FooterBlock footerBlock;

@end
