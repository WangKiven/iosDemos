//
//  ShareOrSaveImage.h
//  刻画
//
//  Created by Kiven Wang on 14-4-1.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SOSTypeShareOrSave,
    SOSTypeShare,
    SOSTypeSave
}SOSType;
/**功能：使用window，在ios7中，使用uimessagebox，会出问题
 *
 *
 */
void ToShareOrSaveImage(UIImage *image, UIView *view);
void ToShareOrSaveImage2(UIImage *image, SOSType sosType, UIView *view);

@interface ShareOrSaveImage : NSObject

+ (id) singleSOS;
+ (void) toShareOrSaveImage:(UIImage *) image Type:(SOSType) sosType View:(UIView *) view;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic) SOSType sosType;

@property (nonatomic, strong) UIView *view;

- (void) start;

@end
