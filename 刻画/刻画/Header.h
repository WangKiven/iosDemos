//
//  Header.h
//  刻画
//
//  Created by apple on 13-12-5.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#ifndef ___Header_h
#define ___Header_h



#endif

#import "util/super/SuperController.h"



//#import <Frontia/FrontiaAuthorization.h>
//#import <Frontia/Frontia.h>
//#import <Frontia/FrontiaShare.h>
//#import <Frontia/FrontiaPush.h>
//#import <Frontia/FrontiaQuery.h>
//#import <Frontia/FrontiaFile.h>
//#import <Frontia/FrontiaData.h>
//#import <Frontia/FrontiaUser.h>
//#import <Frontia/FrontiaRole.h>
//#import <Frontia/FrontiaACL.h>



#import "util/UIMessageBox/UIMessageBox.h"
#import "util/SDWebImage/UIImageView+WebCache.h"
#import "util/common/UIImage+MyExtern.h"
#import "util/common/UIView+SkipperImage.h"
#import "util/common/NSString+MyExtern.h"
#import "util/common/UIDevice+Resolutions.h"
#import "util/common/ALAssetsLibrary+CustomPhotoAlbum.h"
#import "util/common/UIButton+DrawType.h"
#import "util/common/Common.h"
#import "util/common/ShareOrSaveImage.h"

//分享用
#define BAIDUID @"RkTr9EwwkalyHbm47t8RC0Sj"
#define QQID @"101040683"
#define WEIXINID @"wx31070e0d8c577cfb"
#define SINAWEIBO @"3210734969"


//记录版本号
#define Version @"version"
//设置欢迎页
#define FirstCtr @"firstCtr"


//通知用
#define Menu1Open @"menu1open"
#define Menu2Open @"menu2open"

#define StrokeBegin @"strokeBegin"
#define StrokeEnd @"strokeEnd"

#define BeginText @"beginText"
#define EndText @"endText"

#define SelectedStroke @"selectedStroke"
#define NOSelectedStroke @"NOSelectedStroke"

#define ChangeImageColor @"ChangeImageColor"




typedef NS_ENUM(NSInteger, SelectorType) {//SelectorView的显示类型
    SelectorTypeNone,
    SelectorTypeImage,//显示可选择图片
    SelectorTypePath,//显示可选择路径
    SelectorTypeNib//显示可选择笔触
};

typedef NS_ENUM(NSInteger, SelectorSubType) {//SelectorView的显示类型
    //路径
    SelectorPathNone,
    
    SelectorPathSimple,
    SelectorPathLine,//线
    SelectorPathCircle,//园
    SelectorPathCube,//方
    
    SelectorPathKaleidoscope,//万花筒
    //背景
    BackGroundTypeNone,
    BackGroundTypeColor,
    BackGroundTypeImage,
    //笔触
    SelectorNibNone,
    
    SelectorNibSimple,
    SelectorNibPoint,
    SelectorNibPen,
    
    SelectorNibFlower,
    
    SelectorNibAnimal
};

/*
typedef NS_ENUM(NSInteger, SelectorPath) {//笔的轨迹
    SelectorPathNone,
    SelectorPathLine,//线
    SelectorPathCircle,//园
    SelectorPathCube//方
};


typedef NS_ENUM(NSInteger, BackGroundType) {//背景的类型
    BackGroundTypeNone,
    BackGroundTypeColor,
    BackGroundTypeImage
};

typedef NS_ENUM(NSInteger, SelectorNib){//笔触的类型
    SelectorNibNone,
    SelectorNibPoint,
    SelectorNibPen,
    SelectorNibImage
};
*/
