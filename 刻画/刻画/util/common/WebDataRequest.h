//
//  WebDataRequest.h
//  WhereTheDragon
//
//  Created by apple on 13-11-19.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"


#define HTTP @"http://z339349330.xicp.net:8088/WhereTheDragon/client"
#define IMAGEPATH @"http://z339349330.xicp.net:8088/WhereTheDragon/album"
#define URLHTML @"http://z339349330.xicp.net:8088/WhereTheDragon/image.html?id="

typedef NS_ENUM(NSInteger, ImagePath) {
    ImagePathZodiac,//生肖图访问路径
    ImagePathConstellation,//星座图访问路径
    ImagePathImage,//形象图访问路径
    ImagePathDefault,//默认图访问路径
    ImagePathCard,//贺卡访问路径
    ImagePathTemplet,//模板图片访问路径
    ImagePathZodiacgif//gif小图访问路径
};


/*协议：
 *
 *
 */
@protocol WebDataRequestDelegate <NSObject>

@optional

- (void) finishRequest:(NSArray *) datas isError:(BOOL) isError error:(NSString *) error;

- (void) finishImageRequest:(NSData *) imageData isError:(BOOL) isError error:(NSString *) error;

@end










/*接口：
 *
 *
 */

@interface WebDataRequest : NSObject
{
    ASIFormDataRequest *_request;
}

@property (nonatomic, assign) id<WebDataRequestDelegate> delegate;



/*功能：初始化
 *
 *
 */

- (id) initWithDelegate:(id<WebDataRequestDelegate>) delegate;

/*功能：请求数据（通用方法）
 *
 *
 */
- (void) requestData:(NSDictionary *) params action:(NSString *) action;

/*功能：请求图片设计
 *
 *
 */
- (void) requestImageData:(ImagePath) ImagePath ImageName:(NSString *) imageName;

/*功能：检测app版本信息
 *
 *
 */
- (void) getAppVisonMsg:(NSString *) appId;


/*功能：获取图片链接url
 *
 *
 */
+ (NSURL *) getImagePath:(ImagePath) imagePath ImageName:(NSString *) imageName;



/*功能：获取网络状态
 *
 *
 */
+ (NetworkStatus) getNetStatus;

/*功能：异步加载图片 UIImageView+WebCache.h
 *
 *
 */
+ (void) forImageWithCache:(UIImageView *) imageView WithURL:(NSURL *) url placeholderImage:(UIImage *) image;
@end
