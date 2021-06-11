//
//  DLWMMenu+MyExtern.h
//  刻画
//
//  Created by Kiven Wang on 14-2-27.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "DLWMMenu.h"

#import "DLWMLinearLayout.h"

#import "DLWMMenuAnimator.h"

#import "Mark.h"

UIView *menuItemView();

@class DLWMTableMenu;

@protocol DLWMTableMenuDelegate <NSObject>

//- (NSInteger) sectionOfTableMenu:(DLWMTableMenu *) tableMenu;
//
//- (NSInteger) rowOfSection:(NSInteger) section InTableMenu:(DLWMTableMenu *) tableMenu;
//
//- (void) selectedSection:(NSInteger) section InTableMenu:(DLWMTableMenu *) tableMenu;
//
//- (void) selectedRow:(NSIndexPath *) indexPath InTableMenu:(DLWMTableMenu *) tableMenu;



@end

@interface DLWMTableMenu : DLWMMenu




@end

@interface NewMenuAnimator : DLWMMenuAnimator

@end


/*
 *
 *
 *
 */
typedef NS_ENUM(NSInteger, MenuType){
    MenuTypeLeftDown,
    MenuTypeRightDown,
    MenuTypeRightUp,
    MenuTypeLeftUp
};
@interface DLWMTableLinearLayout : DLWMLinearLayout

@property (nonatomic) NSInteger section;

@property (nonatomic) NSInteger row;

@property (nonatomic) MenuType type;

@end


/*颜色、尺寸选择菜单
 *
 *
 *
 */
@protocol ColorAndSizeMenuDelegate <NSObject>

- (void) colorAndSizeDidSelectedWithColor:(UIColor *) color withSize:(CGFloat) size;

@end

@interface ColorAndSizeMenu : DLWMMenu<DLWMMenuDataSource, DLWMMenuItemSource, DLWMMenuDelegate>
{
    NSArray *colors;
    
    NSArray *sizes;
}

@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) NSNumber *selectedSize;
@property (nonatomic, assign) id<ColorAndSizeMenuDelegate> colorSizeDelegate;


- (id) initWithRepresentedObject:(id)representedObject;

@end


/*功能选择菜单
 *
 *
 *
 */

@protocol OptionMenuDelegate <NSObject>

- (void) optionDidSelectedWith:(StrokeType) strokeType;

@end

//共有操作数
#define OPTIONS 6
#define IMAGES @[@"option11.png",@"cicle.png",@"option22.png",@"option33.png",@"option44.png",@"option55.png"]

@interface OptionMenu : DLWMMenu<DLWMMenuDataSource, DLWMMenuItemSource, DLWMMenuDelegate>
{
    NSArray *images;
}

@property (nonatomic) StrokeType strokeType;

@property (nonatomic, assign) id<OptionMenuDelegate> optionDelegate;


- (id) initWithRepresentedObject:(id)representedObject;

@end


