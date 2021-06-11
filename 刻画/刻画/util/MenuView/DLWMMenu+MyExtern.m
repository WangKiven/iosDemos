//
//  DLWMMenu+MyExtern.m
//  刻画
//
//  Created by Kiven Wang on 14-2-27.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "DLWMMenu+MyExtern.h"

#import "DLWMSelectionMenuAnimator.h"

UIView *menuItemView()
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 40.0, 40.0)];
    view.backgroundColor = [UIColor redColor];
    
    view.layer.masksToBounds = YES;
	view.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.75].CGColor;
	view.layer.borderWidth = 1.5;
	view.layer.shadowColor = [UIColor blackColor].CGColor;
	view.layer.shadowOffset = CGSizeMake(0.0, 1.5);
	view.layer.shadowOpacity = 0.5;
	
	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.frame = view.layer.bounds;
	gradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor,
                             (__bridge id)[UIColor colorWithWhite:1.0 alpha:0.1].CGColor,
                             (__bridge id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor,
                             (__bridge id)[UIColor colorWithWhite:1.0 alpha:0.2].CGColor];
	gradientLayer.locations = @[@0.0, @0.49, @0.5, @1.0];
	[view.layer addSublayer:gradientLayer];
	return view;
}

@implementation DLWMTableMenu

@end



@interface DLWMMenuAnimator ()

- (void)willAnimateItem:(DLWMMenuItem *)item atIndex:(NSUInteger)index inMenu:(DLWMMenu *)menu;
- (void)animateItem:(DLWMMenuItem *)item atIndex:(NSUInteger)index inMenu:(DLWMMenu *)menu;
- (void)didAnimateItem:(DLWMMenuItem *)item atIndex:(NSUInteger)index inMenu:(DLWMMenu *)menu finished:(BOOL)finished;

@end
@implementation NewMenuAnimator


- (void)didAnimateItem:(DLWMMenuItem *)item atIndex:(NSUInteger)index inMenu:(DLWMMenu *)menu finished:(BOOL)finished {
	[super didAnimateItem:item atIndex:index inMenu:menu finished:finished];
    
	if (finished) {
		item.alpha = 1.0;
		item.transform = CGAffineTransformIdentity;
	}
}

- (void)animateItem:(DLWMMenuItem *)item atIndex:(NSUInteger)index inMenu:(DLWMMenu *)menu {
    
//	item.alpha = 0.0;
//	item.transform = CGAffineTransformConcat(item.transform, CGAffineTransformMakeScale(2.0, 2.0));
    
}




@end


@implementation DLWMTableLinearLayout

- (void)layoutItems:(NSArray *)items forCenterPoint:(CGPoint)centerPoint inMenu:(DLWMMenu *)menu {
	CGFloat centerSpacing = self.centerSpacing;
	CGFloat itemSpacing = self.itemSpacing;
//	CGFloat angle = self.angle;
    
    
	[items enumerateObjectsUsingBlock:^(DLWMMenuItem *item, NSUInteger index, BOOL *stop) {
        
        
        CGFloat angle1 = 0;
        
        if (index > self.section - 1) {
            index -= self.section;
            if (_type == MenuTypeLeftDown) {
                angle1 = M_PI_2;
            }else if(_type == MenuTypeRightDown){
                angle1 = M_PI_2;
            }else if(_type == MenuTypeRightUp){
                angle1 = M_PI_2 * 2;
            }else if(_type == MenuTypeLeftUp){
                
            }
        }else{
            if (_type == MenuTypeLeftDown) {
                
            }else if(_type == MenuTypeRightDown){
                angle1 = M_PI_2 * 2;
            }else if(_type == MenuTypeRightUp){
                angle1 = M_PI_2 * 3;
            }else if(_type == MenuTypeLeftUp){
                angle1 = M_PI_2 * 3;
            }
        }
        
        CGFloat offset = centerSpacing + itemSpacing * index;
		CGFloat x = centerPoint.x + (offset * cosf(angle1));
		CGFloat y = centerPoint.y + (offset * sinf(angle1));
		CGPoint itemCenter = CGPointMake(x, y);
		item.layoutLocation = itemCenter;
        
	}];
}

@end


@implementation ColorAndSizeMenu


- (id) initWithRepresentedObject:(id)representedObject
{
    
    DLWMTableLinearLayout *layout = [[DLWMTableLinearLayout alloc] initWithAngle:M_PI_2 * 3 itemSpacing:45.0 centerSpacing:50.0];
    layout.section = 3;
    layout.type = MenuTypeLeftUp;
    
    self = [super initWithMainItemView:[self viewForMainItem] dataSource:self itemSource:self delegate:self itemDelegate:nil layout:layout representedObject:representedObject];
    if (self) {
        [self selfInit];
    }
    
    return self;
    
    
}

- (void) selfInit
{
    colors = @[[UIColor redColor], [UIColor orangeColor], [UIColor greenColor], [UIColor cyanColor], [UIColor blueColor]];
    _selectedColor = [colors objectAtIndex:0];
    
    DLWMTableLinearLayout *layout = self.layout;
    layout.section = colors.count - 1;
    
    sizes = @[@3,@4,@6,@8,@12];
    _selectedSize = [sizes objectAtIndex:1];
    
    [self reloadData];
    
    self.mainItem = [[DLWMMenuItem alloc] initWithContentView:[self viewForMainItem] representedObject:self.representedObject];
}

#pragma mark - DLWMMenuDelegate
- (void)receivedSingleTap:(UITapGestureRecognizer *)recognizer onItem:(DLWMMenuItem *)item inMenu:(DLWMMenu *)menu
{
    if (item == self.mainItem) {
        
    }else{
        
        
        NSInteger index = item.contentView.tag - 100;
        
        
        NSInteger ci = [colors indexOfObject:_selectedColor];
        
        NSInteger si = [sizes indexOfObject:_selectedSize];
        
        if (index < colors.count - 1) {
            
            if (index >= ci) {
                index ++ ;
            }
            
            self.selectedColor = [colors objectAtIndex:index];
            
        }else{
            index -= colors.count - 1;
            
            if (index >= si) {
                index ++;
            }
            
            
            self.selectedSize =  [sizes objectAtIndex:index];
            
        }
        
        [self reloadData];
        
        self.mainItem = [[DLWMMenuItem alloc] initWithContentView:[self viewForMainItem] representedObject:self.representedObject];
        
        if (_colorSizeDelegate && [_colorSizeDelegate respondsToSelector:@selector(colorAndSizeDidSelectedWithColor:withSize:)]) {
            [_colorSizeDelegate colorAndSizeDidSelectedWithColor:_selectedColor withSize:[_selectedSize floatValue]];
        }
    }
    
    
    if ([menu isClosedOrClosing]) {
        
        
		[menu open];
        
	} else if ([menu isOpenedOrOpening]) {
		if (item == menu.mainItem) {
			[menu close];
		} else {
            [menu beginFadeAnimation];
			[menu closeWithSpecialAnimator:[[NewMenuAnimator alloc] init] forItem:item];
		}
	}
}

#pragma mark - DLWMMenuDataSource Protocol

- (NSUInteger)numberOfObjectsInMenu:(DLWMMenu *)menu {
    
    NSInteger count =  colors.count + sizes.count - 2;
    
    if (count < 0) {
        count = 0;
    }
    
	return count;
}

- (id)objectAtIndex:(NSUInteger)index inMenu:(DLWMMenu *)menu {
	return @(index);
}

#pragma mark - DLWMMenuItemSource Protocol

- (UIView *)viewForMainItem {
	UIView *view = menuItemView();
	view.bounds = CGRectMake(0.0, 0.0, 50.0, 50.0);
    
    view.backgroundColor = _selectedColor;
    view.layer.borderWidth = 18 - [_selectedSize floatValue];
    
	view.layer.cornerRadius = 25.0;
	CAGradientLayer *gradientLayer = (CAGradientLayer *)view.layer.sublayers[0];
	gradientLayer.cornerRadius = view.layer.cornerRadius;
	gradientLayer.frame = view.layer.bounds;
    
    
    
    
	return view;
}

- (UIView *)viewForObject:(id)object atIndex:(NSUInteger)index inMenu:(DLWMMenu *)menu {
    
    NSInteger ci = [colors indexOfObject:_selectedColor];
    
    NSInteger si = [sizes indexOfObject:_selectedSize];
    
    
    
    
	UIView *view = menuItemView();
    
    view.tag = index + 100;
    
	view.bounds = CGRectMake(0.0, 0.0, 40.0, 40.0);
    
    if (index < colors.count - 1) {
        
        if (index >= ci) {
            index ++ ;
        }
        
        view.backgroundColor = [colors objectAtIndex:index];
        
    }else{
        index -= colors.count - 1;
        
        if (index >= si) {
            index ++;
        }
        
        
        view.backgroundColor = [UIColor blackColor];
        
        NSNumber *nu = [sizes objectAtIndex:index];
        
        view.layer.borderWidth = 14 - [nu floatValue];
    }
    
    
    
    
    view.layer.cornerRadius = 20.0;
	CAGradientLayer *gradientLayer = (CAGradientLayer *)view.layer.sublayers[0];
	gradientLayer.cornerRadius = view.layer.cornerRadius;
	gradientLayer.frame = view.layer.bounds;
    
    
    
    
	return view;
}

@end


@implementation OptionMenu

- (id) initWithRepresentedObject:(id)representedObject
{
    DLWMTableLinearLayout *layout = [[DLWMTableLinearLayout alloc] initWithAngle:M_PI_2 * 2 itemSpacing:45.0 centerSpacing:50.0];
    layout.section = 10;
    layout.type = MenuTypeRightUp;
    
    self = [super initWithMainItemView:[self viewForMainItem] dataSource:self itemSource:self delegate:self itemDelegate:nil layout:layout representedObject:representedObject];
    if (self) {
        [self selfInit];
    }
    
    return self;
}

- (void) selfInit
{
    
    images = IMAGES;
    
    _strokeType = StrokeTypeLine;
    
    
    DLWMTableLinearLayout *layout = self.layout;
    layout.section = OPTIONS - 1;

    
    [self reloadData];
    
    self.mainItem = [[DLWMMenuItem alloc] initWithContentView:[self viewForMainItem] representedObject:self.representedObject];
}

#pragma mark - DLWMMenuDelegate
- (void)receivedSingleTap:(UITapGestureRecognizer *)recognizer onItem:(DLWMMenuItem *)item inMenu:(DLWMMenu *)menu
{
    if (item == self.mainItem) {
//        if (_optionDelegate && [_optionDelegate respondsToSelector:@selector(optionDidSelectedWith:)]) {
//            [_optionDelegate optionDidSelectedWith:3];
//        }
    }else{

        
        NSInteger index = item.contentView.tag - 100;
        
        if (index >= _strokeType - 1) {
            index ++ ;
        }
        
        StrokeType newStrokeType =  index + 1;
        
        if (index + 1 >= StrokeTypeCliperImage) {
            
        }else{
            
            _strokeType = newStrokeType;
        }
        
        [self reloadData];
        
        self.mainItem = [[DLWMMenuItem alloc] initWithContentView:[self viewForMainItem] representedObject:self.representedObject];
        
        if (_optionDelegate && [_optionDelegate respondsToSelector:@selector(optionDidSelectedWith:)]) {
            [_optionDelegate optionDidSelectedWith:newStrokeType];
        }
    }
    
    
    if ([menu isClosedOrClosing]) {
        
        
		[menu open];
        
	} else if ([menu isOpenedOrOpening]) {
		if (item == menu.mainItem) {
			[menu close];
		} else {
            [menu beginFadeAnimation];
			[menu closeWithSpecialAnimator:[[NewMenuAnimator alloc] init] forItem:item];
		}
	}
}

#pragma mark - DLWMMenuDataSource Protocol

- (NSUInteger)numberOfObjectsInMenu:(DLWMMenu *)menu {
    
    return OPTIONS - 1;
}

- (id)objectAtIndex:(NSUInteger)index inMenu:(DLWMMenu *)menu {
	return @(index);
}

#pragma mark - DLWMMenuItemSource Protocol

- (UIView *)viewForMainItem {
	UIView *view = menuItemView();
	view.bounds = CGRectMake(0.0, 0.0, 50.0, 50.0);
    
    UIImage *image = [UIImage imageNamed:[images objectAtIndex:_strokeType - 1]];
    image = [image imageWithTintColor:[BackgroundData naviBarTextColor]];
    view.backgroundColor = [UIColor colorWithPatternImage: image];
    
	view.layer.cornerRadius = 25.0;
	CAGradientLayer *gradientLayer = (CAGradientLayer *)view.layer.sublayers[0];
	gradientLayer.cornerRadius = view.layer.cornerRadius;
	gradientLayer.frame = view.layer.bounds;
    
    
    
    
	return view;
}

- (UIView *)viewForObject:(id)object atIndex:(NSUInteger)index inMenu:(DLWMMenu *)menu {
    
    
	UIView *view = menuItemView();
    
    view.tag = index + 100;
    
	view.bounds = CGRectMake(0.0, 0.0, 40.0, 40.0);
    
    
    if (index >= _strokeType - 1) {
        index ++ ;
    }
    
    UIImage *image = [[UIImage imageNamed:[images objectAtIndex:index]] ImageInSize:CGSizeMake(40, 40)];
    image = [image imageWithTintColor:[BackgroundData naviBarTextColor]];
    view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    view.layer.cornerRadius = 20.0;
	CAGradientLayer *gradientLayer = (CAGradientLayer *)view.layer.sublayers[0];
	gradientLayer.cornerRadius = view.layer.cornerRadius;
	gradientLayer.frame = view.layer.bounds;
    
    
    
    
	return view;
}

@end






