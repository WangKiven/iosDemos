//
//  Common.h
//  扩展
//
//  Created by apple on 14-1-21.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <Foundation/Foundation.h>


/**功能：返回颜色color,尺寸size的image
 *
 *
 */
UIImage *getImage(UIColor *color, CGSize size);

/**功能：返回大小fontSize的，app通用字体
 *
 *
 */
UIFont *getNewFont(CGFloat fontSize);

/**功能：返回屏幕尺寸size
 *
 *
 */
CGSize getScreenSize();


/**功能：返回系统版本
 *
 *
 */
CGFloat getDeviceVersion();

/**功能：返回设备名称，如 iPhone
 *
 *
 */
NSString *getDeviceName();

/**功能：判断设备是否是iPad/iPhone
 *
 *
 */
BOOL isIPad();
BOOL isIPhone();

/**功能：返回APP版本
 *
 *
 */
CGFloat getAppVersion();

/**功能：获取Window
 *
 *
 */
UIWindow *getWindow();

/**功能：界面风格类
 *
 *
 */
@interface BackgroundData : NSObject

+ (BackgroundData *) shareBackgroundData;//单列

+ (void) setBackgroundType:(NSInteger) type;//设置界面风格

+ (NSArray *) listBgDataForShow;//获取表格展示数据

+ (UIColor *) naviBarBgColor;//导航栏颜色

+ (UIColor *) naviBarTextColor;//导航栏文字颜色

+ (UIColor *) bgColor;//界面背景图片




@property (nonatomic) NSInteger type;//界面风格类型

@end



@interface Common : NSObject

@end
