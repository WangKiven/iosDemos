//
//  SettingController.m
//  刻画
//
//  Created by apple on 13-12-18.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import "SettingController.h"
#import "ThemeViewController.h"
#import "AboutUsViewController.h"
#import "IntroViewController.h"

@interface SettingController ()<UIActionSheetDelegate>

@end

@implementation SettingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //调整界面风格
    
    self.view.backgroundColor = [BackgroundData naviBarBgColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else if(section == 1){
        return 1;
    }else{
        return 1;
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"xx"];
    
    cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString *text = @"";
    NSString *detailText = @"";
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                text = @"欢迎页";
            }
                break;
            case 1:
            {
                text = @"主题";
            }
                break;
            case 2:
            {
                text = @"引导界面";
            }
                break;
                
            default:
                break;
        }
        
        
    }else if(indexPath.section == 1){
        
        text = @"清除授权账号";
        
    }else{
        text = @"关于PhotoEdit";
    }
    
    cell.textLabel.text = text;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    cell.detailTextLabel.text = detailText;
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
            {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"设置欢迎页" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"相册", nil];
                
                [actionSheet showInView:self.view];
            }
                break;
            case 1:
            {
                ThemeViewController *themCtr = [ThemeViewController initF];
                
                [self.navigationController pushViewController:themCtr animated:YES];
            }
                break;
            case 2:
            {
                IntroViewController *intro = [[IntroViewController alloc] init];
                
                [self.navigationController pushViewController:intro animated:NO];
            }
                break;
                
            default:
                break;
        }
    }else if(indexPath.section == 1){
        
        /*FrontiaAuthorization *auth = [Frontia getAuthorization];
        
        NSString *errorStr;
        if ([auth clearAllAuthorizationInfo]) {
            errorStr = @"清除授权成功";
        }else{
            errorStr = @"清除授权失败！";
        }
        
        [UIMessageBox showMessageBoxInView:self.view withText:errorStr];
        [UIMessageBox hideMessageBoxInView:self.view];*/
        
    }else{
        AboutUsViewController *about = [[AboutUsViewController alloc] init];
        
        [self.navigationController pushViewController:about animated:YES];
    }
    
    
    
    
    
    
    [tableView reloadData];
}


#pragma mark - UIActionSheetDelegate

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    switch (buttonIndex) {
        case 0:
        {
            [defaults setInteger:0 forKey:FirstCtr];
        }
            break;
        case 1:
        {
            [defaults setInteger:1 forKey:FirstCtr];
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
}
@end
