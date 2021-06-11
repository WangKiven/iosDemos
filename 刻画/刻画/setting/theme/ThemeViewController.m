//
//  ThemeViewController.m
//  刻画
//
//  Created by Kiven Wang on 14-3-18.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeCell.h"
#import "UIButton+DrawType.h"

@interface ThemeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;



@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ThemeViewController

+ (id) initF
{
    NSString *nibName = @"ThemeViewController";
    
    if (isIPad()) {
        nibName = @"ThemeViewController_iPad";
    }
    
    
    ThemeViewController *theme = [[ThemeViewController alloc] initWithNibName:nibName bundle:nil];
    
    return theme;
}

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
    
    _dataArray = [BackgroundData listBgDataForShow];
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"ThemeCell" bundle:nil] forCellWithReuseIdentifier:Iden];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    self.view.backgroundColor = [BackgroundData bgColor];
    
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSIndexPath *selectedPath = [NSIndexPath indexPathForRow:[BackgroundData shareBackgroundData].type inSection:0];
    [_collectionView selectItemAtIndexPath:selectedPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ThemeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Iden forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:[_dataArray objectAtIndex:indexPath.row]];
    
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 8;
    
    return cell;
}
#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    
    
    [BackgroundData setBackgroundType:indexPath.row];
    
    //修改颜色
    self.navigationController.navigationBar.tintColor = [BackgroundData naviBarBgColor];
    self.navigationController.navigationBar.backgroundColor = [BackgroundData naviBarBgColor];
    self.view.backgroundColor = [BackgroundData bgColor];
    
    
    [WButton SetButtonColor:[BackgroundData naviBarTextColor]];
}

@end
