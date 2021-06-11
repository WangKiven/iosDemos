//
//  Common.m
//  扩展
//
//  Created by apple on 14-1-21.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "Common.h"


UIImage *getImage(UIColor *color, CGSize size)
{
    //支持retina高分的关键
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0.0f, 0.0f, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

UIFont *getNewFont(CGFloat fontSize)
{
    return [UIFont fontWithName:@"DFPShaoNvW5" size:fontSize];
}

CGSize getScreenSize()
{
    return [UIScreen mainScreen].bounds.size;
}

CGFloat getDeviceVersion()
{
    return [[UIDevice currentDevice] systemVersion].floatValue;
}


NSString *getDeviceName()
{
    return [[UIDevice currentDevice] model];
}

BOOL isIPad()
{
//    return [getDeviceName() containsSubString1:@"iPad"];
    return true;
    
}
BOOL isIPhone()
{
//    return [getDeviceName() containsSubString1:@"iPhone"];
    return true;
}

CGFloat getAppVersion()
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
    
    return currentVersion.floatValue;
}


UIWindow *getWindow()
{
    return [UIApplication sharedApplication].keyWindow;
}



#define SelectedBgType @"selectedBgType"
@implementation BackgroundData

static BackgroundData *backgroundData_;

- (id) init
{
    self = [super init];
    if (self) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        self.type = [ud integerForKey:SelectedBgType];
        
    }
    return self;
}

- (void) setType:(NSInteger)type
{
    _type = type;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setInteger:_type forKey:SelectedBgType];
}

+ (BackgroundData *) shareBackgroundData
{
    if (!backgroundData_) {
        backgroundData_ = [[BackgroundData alloc] init];
    }
    return backgroundData_;
}


+ (void) setBackgroundType:(NSInteger) type
{
    BackgroundData *bgd = [BackgroundData shareBackgroundData];
    
    bgd.type = type;
}

+ (NSArray *) listBgDataForShow
{
    static NSArray *listData;
    
    if (!listData) {
        listData = @[@"show2", @"show1"];
    }
    
    return listData;
}

+ (NSArray *) listNaviBarData
{
    static NSArray *naviBarData;
    
    if (!naviBarData) {
        naviBarData = @[[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1],
                        [UIColor colorWithRed:0.94 green:0.77 blue:0.87 alpha:1],//浪漫
//                        [UIColor colorWithRed:0.84 green:0.91 blue:0.71 alpha:1],//纯真
//                        [UIColor colorWithRed:0.56 green:0.79 blue:0.84 alpha:1],//优美
//                        [UIColor colorWithRed:0.94 green:0.66 blue:0.51 alpha:1],//安稳
//                        [UIColor colorWithRed:0.45 green:0.28 blue:0.54 alpha:1],//童话
//                        [UIColor colorWithRed:0.33 green:0.6 blue:0.78 alpha:1],//未来
//                        [UIColor colorWithRed:0.62 green:0.47 blue:0.64 alpha:1],//希望
//                        [UIColor colorWithRed:0.35 green:0.71 blue:0.62 alpha:1],//进步
//                        [UIColor colorWithRed:0.9 green:0.52 blue:0.49 alpha:1],//优雅
//                        [UIColor colorWithRed:0.52 green:0.51 blue:0.51 alpha:1]//坚实
                        ];
    }
    
    return naviBarData;
}

+ (NSArray *) listButtonData
{
    static NSArray *listButtonData;
    if (!listButtonData) {
        listButtonData = @[[UIColor colorWithRed:0.03 green:0.44 blue:0.84 alpha:1],
                           [UIColor colorWithRed:0.35 green:0.71 blue:0.62 alpha:1],
//                           [UIColor colorWithRed:0.83 green:0.64 blue:0.76 alpha:1],
//                           [UIColor colorWithRed:0.67 green:0.57 blue:0.65 alpha:1],
//                           [UIColor colorWithRed:0.84 green:0.9 blue:0.71 alpha:1],
//                           [UIColor colorWithRed:0.52 green:0.54 blue:0.65 alpha:1],
//                           [UIColor colorWithRed:0 green:0.28 blue:0.55 alpha:1],
//                           [UIColor colorWithRed:0.23 green:0.18 blue:0.45 alpha:1],
//                           [UIColor colorWithRed:0 green:0.27 blue:0.51 alpha:1],
//                           [UIColor colorWithRed:0.62 green:0.47 blue:0.64 alpha:1],
//                           [UIColor colorWithRed:0 green:0.27 blue:0.51 alpha:1]
                           ];
    }
    
    return listButtonData;
}

+ (NSArray *) listBgData
{
    static NSArray *listBgData;
    
    if (!listBgData) {
        listBgData = [BackgroundData listNaviBarData];
    }
    
    return listBgData;
}

+ (UIColor *) naviBarBgColor
{
    
    BackgroundData *bgd = [BackgroundData shareBackgroundData];
    return [[BackgroundData listNaviBarData] objectAtIndex:bgd.type];
}

+ (UIColor *) naviBarTextColor
{
    
    BackgroundData *bgd = [BackgroundData shareBackgroundData];
    return [[BackgroundData listButtonData] objectAtIndex:bgd.type];
}

+ (UIColor *) bgColor
{
    
    BackgroundData *bgd = [BackgroundData shareBackgroundData];
    return [[BackgroundData listBgData] objectAtIndex:bgd.type];
}

@end

@implementation Common

@end
