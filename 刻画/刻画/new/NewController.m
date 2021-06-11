//
//  NewController.m
//  刻画
//
//  Created by apple on 13-12-5.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import "NewController.h"
#import "DLWMMenu.h"
#import "DLWMMenuAnimator.h"
#import "DLWMSpringMenuAnimator.h"
#import "DLWMSelectionMenuAnimator.h"
#import "EditImageController.h"
#import "PsImageController.h"
#import "DLWMMenu+MyExtern.h"

@interface NewController ()< ColorAndSizeMenuDelegate, OptionMenuDelegate, UIActionSheetDelegate, EditImageControllerDelegate, PsImageDelegate>
{
    
    NSUndoManager *undoManager;
    
}

@property (readwrite, strong, nonatomic) ColorAndSizeMenu *menu1;
@property (readwrite, strong, nonatomic) OptionMenu *menu2;

//未使用
@property (readwrite, assign, nonatomic) NSUInteger items;
@property (readwrite, assign, nonatomic) CGFloat itemSpacing;
@property (readwrite, assign, nonatomic) CGFloat centerSpacing;
@property (readwrite, assign, nonatomic) CGFloat angle;






@end

@implementation NewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
    
    
    undoManager = [[NSUndoManager alloc] init];
    
    [undoManager setLevelsOfUndo:999];
    
    self.drawPadView.theUndoManager = undoManager;
    
    
	self.items = 5;
	self.itemSpacing = 45.0; // in pixels
	self.centerSpacing = 50.0; // in pixels
	self.angle = M_PI_2 * 3; // in radians
	
	
	CGRect frame = [UIScreen mainScreen].bounds;
    
    
	
    
    _menu1 = [[ColorAndSizeMenu alloc] initWithRepresentedObject:self];
    
    _menu1.colorSizeDelegate = self;
    
    _menu1.tag = 101;
    
	_menu1.openAnimationDelayBetweenItems = 0.01;
	_menu1.closeAnimationDelayBetweenItems = 0.01;
	if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        _menu1.center = CGPointMake(40, CGRectGetWidth(frame) - 40);
    }else{
        
        _menu1.center = CGPointMake(40, CGRectGetHeight(frame) - 40);
    }
    
	
	
	[self.view addSubview:self.menu1];
    
    
    
    
    _menu2 = [[OptionMenu alloc] initWithRepresentedObject:self];
    
    _menu2.tag = 102;
    _menu2.optionDelegate = self;
    
	_menu2.openAnimationDelayBetweenItems = 0.01;
	_menu2.closeAnimationDelayBetweenItems = 0.01;
	
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        _menu2.center = CGPointMake(CGRectGetHeight(frame) - 40, CGRectGetWidth(frame) - 40);
    }else{
        
        _menu2.center = CGPointMake(CGRectGetWidth(frame) - 40, CGRectGetHeight(frame) - 40);
    }
	
	
	[self.view addSubview:self.menu2];
    
	
    self.imageView.image = self.image;
    
    
    
    
    //接收通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginTextStroke:) name:BeginText object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endTextStroke:) name:EndText object:nil];
}


- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    //调整界面风格
    
    self.view.backgroundColor = [BackgroundData bgColor];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
    _menu1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    _menu2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
    
    
	
	[self.menu1 closeAnimated:NO];
	[self.menu2 closeAnimated:NO];
}

- (void) setImage:(UIImage *)image
{
    if (_image == image) {
        return;
    }
    
    _image = image;
    
    self.imageView.image = _image;
}

#pragma mark - 隐藏status bar ios7.0
- (BOOL)prefersStatusBarHidden {
    
    return YES;
}





#pragma mark - 震动
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
    
}

#pragma mark - Action
- (IBAction)toExitAction:(id)sender {
    
    
    
    if (!undoManager.canUndo) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"你的编辑尚未保存或分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出" otherButtonTitles: nil];
        
        [sheet showInView:self.view];
    }
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (IBAction)toRemoveAction:(id)sender{
    Scribble *newScribble = [[Scribble alloc] init];
    
    [_drawPadView setNewScribble:newScribble];
}

- (IBAction)toBackAction:(id)sender {
    
    [self.view beginFadeAnimation];
    [self.drawPadView undo];
}

- (IBAction)toProntAction:(id)sender {
    
    
    [self.view beginFadeAnimation];
    [self.drawPadView redo];
}

- (IBAction)toSaveOrShareAction:(id)sender {
    [self.drawPadView.scribble cancleAllSeleted];
    [self.drawPadView deleteButtonHidden:YES];
    
    ToShareOrSaveImage([self.drawPadView.superview skipImage], self.view);
}

#pragma mark - 设备旋转

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.drawPadView setNeedsDisplay];
}

#pragma mark - ColorAndSizeMenuDelegate

- (void) colorAndSizeDidSelectedWithColor:(UIColor *)color withSize:(CGFloat)size
{
    _drawPadView.strokeColor = color;
    
    _drawPadView.strokeSize = size;
}

#pragma mark - optionDelegate

- (void) optionDidSelectedWith:(StrokeType)strokeType
{
    if (strokeType == StrokeTypeCliperImage) {
        
        if (!self.imageView.image) {
            
            [UIMessageBox showMessageBoxInView:self.view withText:@"没有可操作的图片！"];
            [UIMessageBox hideMessageBoxInView:self.view];
            
            return ;
        }
        
        EditImageController *editCtr = [[EditImageController alloc] init];
        
        editCtr.delegate = self;
        
        editCtr.isStandard = YES;
        
        editCtr.image = self.imageView.image;
        
        [self.navigationController pushViewController:editCtr animated:YES];
        
        
    }else if(strokeType == StrokeTypePsImage){
        if (!self.imageView.image) {
            
            [UIMessageBox showMessageBoxInView:self.view withText:@"没有可操作的图片！"];
            [UIMessageBox hideMessageBoxInView:self.view];
            
            return ;
        }
        PsImageController *psCtr = [[PsImageController alloc] init];
        
        psCtr.delegate = self;
        
        psCtr.isStandard = YES;
        
        psCtr.image = self.imageView.image;
        
        [self.navigationController pushViewController:psCtr animated:YES];
    }else{
        
        _drawPadView.strokeType = strokeType;
    }
    
}


#pragma mark - EditImageControllerDelegate

- (void) editImageFinshWith:(UIImage *)image
{
//    self.image = image;
//    
//    self.imageView.image = image;
    
    UIImage *oldImage = self.imageView.image;
    
    NSLog(@"%@",NSStringFromCGSize(_image.size));
    
    NSInvocation *moveInvocation = [self changeImage];
    [moveInvocation setArgument:&image atIndex:2];
    
    
    NSInvocation *unMoveInvocation = [self changeImage];
    [unMoveInvocation setArgument:&oldImage atIndex:2];
    
    [self.drawPadView executeInvocation:moveInvocation withUndoInvocation:unMoveInvocation];
    
    
}

- (NSInvocation *) changeImage
{
    NSMethodSignature *removeSignature = [self.imageView methodSignatureForSelector:@selector(setImage:)];
    NSInvocation *removeInvocation = [NSInvocation invocationWithMethodSignature:removeSignature];
    
    [removeInvocation setTarget:self.imageView];
    [removeInvocation setSelector:@selector(setImage:)];
    
    return removeInvocation;
}

#pragma mark - PsImageDelegate

- (void) psImageFinshWith:(UIImage *)image
{
    [self editImageFinshWith:image];
}

#pragma mark - 通知
- (void) beginTextStroke:(NSNotification *) notification
{
    
//    UIView *view = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
//    
//    view.backgroundColor = [UIColor clearColor];
//    
//    view.tag = 333;
//    
//    [self.view addSubview:view];
    
    [self buttonHidden:YES];
}
- (void) endTextStroke:(NSNotification *) notification
{
//    for (UIView *view in self.view.subviews) {
//        if (view.tag != 333) {
//            [view removeFromSuperview];
//        }
//    }
    
    [self buttonHidden:NO];
}

#pragma mark - 隐藏、显示组件

- (void) buttonHidden:(BOOL) hidden
{
    //在xib中设置DrawPadView的tag = 222
    for (UIView *view in self.view.subviews) {
        if (view.tag != 222) {
            view.hidden = hidden;
        }
    }
    
    [self.view beginFadeAnimation];
}

@end
