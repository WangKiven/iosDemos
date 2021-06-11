//
//  SelectorView.h
//  刻画
//
//  Created by apple on 13-12-18.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectorViewDelegate;



@interface SelectorView : UIView<UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSMutableDictionary *_bgImages;
    
    NSMutableDictionary *_nibs;
    
    NSMutableArray *_paths;
    
    NSArray *_currArray;
    
}

@property(nonatomic) SelectorType selectorType;
@property(nonatomic) SelectorSubType selectorSubType;

@property(nonatomic,assign) id<SelectorViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segCtr;



- (IBAction)changeValueAction:(id)sender;



@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;



@end

//-----协议-----
@protocol SelectorViewDelegate <NSObject>

@optional
- (void) selectorView:(SelectorView *) selectorView didSelectedBackgroundImage:(UIImage *) image orColor:(UIColor *) color withBackGroundType:(SelectorSubType) backGroundType;

- (void) selectorView:(SelectorView *) selectorView didSelectedPath:(SelectorSubType) selectorPath;

- (void) selectorView:(SelectorView *) selectorView didSelectedNib:(SelectorSubType) selectorNib withImage:(UIImage *) image;


@end